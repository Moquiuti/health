//	JS para el historico de datos de un producto
//	Ultima revisión ET 11jun23. HistoricoComprasProducto2022_110623.js

//	funcion a ejecutar al cargarse la pagina
function Inicio()
{
	console.log('Inicio. 11jun23 15:40');
	
	PreparaArrayMeses();
	PresentaTabla();
	PresentaGrafico(-1);
}


function PreparaArrayMeses()
{
	var MesInicial=MesActual+1;	
	var AnnoInicial=AnnoActual-NumMesesTabla/12;

	if (MesInicial>12) 	
	{
		MesInicial=1;
		AnnoActual++;
	}

	arrEntradasMes = new Array();

	//	Prepara la tabla vacia
	var Mes=MesInicial;
	var Anno=AnnoInicial;

	//	Empezamos a contar en la columna 1
	Entrada=[];
	Entrada["Mes"]=0;
	Entrada["Anno"]=0;
	arrEntradasMes.push(Entrada);

	//	Crea la tabla vacia
	for (var i=1;i<=NumMesesTabla;++i)
	{
		Entrada=[];
		
		Entrada["Mes"]=Mes;
		Entrada["Anno"]=Anno;
		Entrada["Precio"]=-1;	//	Para identificar que falta informarlo
		Entrada["Cantidad"]=0;
		Entrada["Importe"]=0;
		Entrada["Centros"]=[]
		
		var PrecioNoInformado=true;
		var CantCentro=[];

		for (var k=0;k<arrCentros.length;++k)
		{
			var Centro=[]
			Centro["Cantidad"]=0;
			Centro["Importe"]=0;
			
			Entrada["Centros"].push(Centro);
		}
		
		arrEntradasMes.push(Entrada);

		++Mes;
		
		if (Mes>12) 	
		{
			Mes=1;
			Anno++;
		}

		console.log('PreparaArrayMeses. INICIALIZAR a 0. Mes:'+Mes+' Anno:'+Anno+' col:'+i);
	}

	console.log('PreparaArrayMeses. Preparar centros. Num:'+arrCentros.length);

	
	//	Recorre los centros
	for (var c=0;c<arrCentros.length;++c)
	{

		console.log('PreparaArrayMeses. Preparar centro['+c+']. Lineas:'+arrCentros[c].Lineas.length);

		//	SI el centro esta informado, prepara las lineas
		if (arrCentros[c].Lineas.length>0)
		{
			var UltIndice=-1;
						
			for (var l=0;l<arrCentros[c].Lineas.length;++l)
			{
				var Mes=arrCentros[c].Lineas[l].Mes;
				var Anno=arrCentros[c].Lineas[l].Anno;
					
				console.log('PreparaArrayMeses. Buscar IND. Mes:'+Mes+' Anno:'+Anno+' UltIndice:'+UltIndice);

				var Indice=-1;
				for (var j=0;((j<arrEntradasMes.length)&&(Indice==-1));++j)
				{
					if ((Mes==arrEntradasMes[j].Mes)&&(Anno==arrEntradasMes[j].Anno))
					{
						Indice=j;
					}
					else if ((j>UltIndice)&&(UltIndice>=0))
					{
						arrEntradasMes[j].Centros[c].Cantidad=0;
						arrEntradasMes[j].Centros[c].Importe=0;
						console.log('PreparaArrayMeses. Buscar IND. Mes:'+Mes+' Anno:'+Anno+' Indice:'+Indice+' UltIndice:'+UltIndice+'.Completar valores');
					}
				}
				UltIndice=Indice;
				
				if (Indice!=-1)
				{
					arrEntradasMes[Indice].Centros[c].Cantidad=arrCentros[c].Lineas[l].Cantidad;
					arrEntradasMes[Indice].Centros[c].Importe=arrCentros[c].Lineas[l].ImporteTotal;
					console.log('PreparaArrayMeses. Buscar IND. Mes:'+Mes+' Anno:'+Anno+' Indice:'+Indice+' UltIndice:'+UltIndice
							+'. Cantidad:'+arrCentros[c].Lineas[l].Cantidad+' ImporteTotal:'+arrCentros[c].Lineas[l].ImporteTotal);
				}
			
			}
		}
	}

/*	
	//	Prepara la fila de totales
	var Centro=[];
	Centro["ID"]=0;
	Centro["Nombre"]=txtTotal;
	Centro["Lineas"]=new Array();	

	//	Crea la tabla vacia
	for (var i=0;i<=NumMesesTabla;++i)
	{
		Entrada=[];
		
		Entrada["Mes"]=arrEntradasMes[j].Centros[0].Mes;
		Entrada["Anno"]=arrEntradasMes[j].Centros[0].Anno;
		Entrada["Precio"]=arrEntradasMes[j].Centros[0].Precio;
		var Cantidad=0,Importe=0;
		for (var c=0;c<arrCentros[c].length;++c)
		{
			Cantidad+=arrEntradasMes[i].Centros[c].Cantidad;
			Importe+=arrEntradasMes[i].Centros[c].Importe;
		}		
		Entrada["Cantidad"]=Cantidad;
		Entrada["Importe"]=Importe;
		
	}
	
	arrEntradasMes.push(Entrada);
*/				
}



//	Prepara la tabla correspondiente a los ultimos 2 annos
function PresentaTabla()
{
	tablaHTML='<table class="w95 tableCenter" cellspacing="2px" cellpadding="2px" border="1px"><thead><tr class="fuentePeq">';

	//	cabecera de la tabla
	tablaHTML+='<th class="textLeft">'+txt_Fecha+'</th>';
	for (var i=1;i<=NumMesesTabla;++i)
	{
		console.log('PresentaTabla('+i+'):'+arrEntradasMes[i].Mes+'/'+arrEntradasMes[i].Anno);
		tablaHTML+='<th>'+arrMeses[arrEntradasMes[i].Mes].Nombre.substring(0,3)+'<br/>'+(arrEntradasMes[i].Anno-2000)+'</th>';
	}
	
	tablaHTML+='</tr></thead><tbody>';
	
	
	//	Bucle sobre centros/categorias cuando corresponda
	for (var c=0;c<arrCentros.length;++c)
	{
		if (arrCentros[c].Lineas.length>0)	//inlcuimos linea de totales
		{
			//	titulo de la fila
			tablaHTML+='<tr class="fuentePeq"><td class="textLeft"><a href="javascript:PresentaGrafico('+c+');">'+arrCentros[c].Nombre+'</a></td>';
			//	cabecera de la tabla
			for (var i=1;i<=NumMesesTabla;++i)
			{
				console.log('PresentaTabla. Indice:'+i+ 'Salida:'+arrEntradasMes[i].Centros[c].Cantidad);
				tablaHTML+='<td class="textRight">'+arrEntradasMes[i].Centros[c].Cantidad+'</td>';
			}
			tablaHTML+='</tr>';
		}
	}
	
	//Fila totales
	
	tablaHTML+='</tbody><table>';
	
	jQuery('#divTablaDatos').html('<span class="marginLeft50"><bold>'+jQuery("#REFPRODESTANDAR option:selected").text()+'</bold></span><br/><br/>'+tablaHTML);
}

/*
//	Cambia el centro seleccionado y genera la busqueda
function CambiaCentro(IDCentro)
{
	jQuery('#IDCENTRO').val(IDCentro);
	Buscar();
}
*/




//
//	Declaraciones y funciones para el manejo de los graficos
//
var myChart;

//	Paleta de colores, para hasta 40 líneas
var PaletaColores=['#0932F0','#204A87','#F00923','#48DAF1','#2EF953','#F28C87','#7C8486','#8F5902','#C17D11','#E9B96E','#EDD400',
'#729FCF','#73D216','#F57900','#FCE94F','#888A85','#A40000','#8F5902','#729FCF','#5C3566','#C4A000','#8AE234',
'#555753','#AD7FA8','#F4F137','#F4373B','#74A4E1','#CE259E','#873570','#F76E0B','#80CD18','#7279A5','#4F209F',
'#2E3436','#C6C44E','#3465A4','#F5902D','#A4EC43','#939EDC','#A37FE0','#7FE0CB','#516E94','#EB090E','#E32FCF'];

/*
//	Prepara el grafico por meses
function PresentaGraficoCentro(IDCentro)
{	
	var Datasets=[];
	var Columnas=[];
	var Labels =[];
	
	var Dataset= [];
	Dataset["data"]=[];	
	for (var i=0;i<arrEntradasMes.length-1;++i)
	{
		//	El array arrEntradasMes empieza en 1, labels y data en 0
		Labels[i]=arrEntradasMes[i+1].Mes+'/'+(arrEntradasMes[i+1].Anno-2000);
		Dataset["data"][i]=arrEntradasMes[i+1].Existencias;
	}	
	Dataset["label"]=jQuery("#REFPRODESTANDAR option:selected").text()+'. '+txtExistencias;
    Dataset["borderColor"]="#2061C0";
    Dataset["backgroundColor"]="#2061C0";
    Dataset["fill"]=false;
	Datasets.push(Dataset);

	var Dataset= [];
	Dataset["data"]=[];	
	for (var i=0;i<arrEntradasMes.length-1;++i)
	{
		//	El array arrEntradasMes empieza en 1, labels y data en 0
		Dataset["data"][i]=arrEntradasMes[i+1].Entradas;
	}	
	Dataset["label"]=jQuery("#REFPRODESTANDAR option:selected").text()+'. '+ txtEntradas;
    Dataset["borderColor"]="#447F0D";
    Dataset["backgroundColor"]="#447F0D";
    Dataset["fill"]=false;
	Datasets.push(Dataset);

	var Dataset= [];
	Dataset["data"]=[];	
	for (var i=0;i<arrEntradasMes.length-1;++i)
	{
		//	El array arrEntradasMes empieza en 1, labels y data en 0
		Dataset["data"][i]=-arrEntradasMes[i+1].Salidas;
	}	
	Dataset["label"]=jQuery("#REFPRODESTANDAR option:selected").text()+'. '+ txtSalidas;
    Dataset["borderColor"]="#CF2E23";
    Dataset["backgroundColor"]="#CF2E23";
    Dataset["fill"]=false;
	Datasets.push(Dataset);

	if (document.getElementById("actMensual"))
	{
    	var ctx = document.getElementById("actMensual").getContext('2d');

		if (myChart)
        	myChart.destroy();

    	myChart = new Chart(ctx, {
        	type: 'line',
        	data: {
            	labels: Labels,
				//borderColor: PaletaColores,
				//backgroundColor: PaletaColores,
            	datasets: Datasets,
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
*/

//	Prepara el grafico por meses
function PresentaGrafico(PosCentro)
{	
	var Datasets=[];
	var Columnas=[];
	var Labels =[];

	for (var i=0;i<arrEntradasMes.length-1;++i)
	{
		//	El array arrEntradasMes empieza en 1, labels y data en 0
		Labels[i]=arrEntradasMes[i+1].Mes+'/'+(arrEntradasMes[i+1].Anno-2000);
	}	

	if (PosCentro!=-1)
	{
		var Dataset= [];
		Dataset["data"]=[];	
		for (var i=0;i<arrEntradasMes.length-1;++i)
		{
			//	El array arrEntradasMes empieza en 1, labels y data en 0
			Dataset["data"][i]=arrEntradasMes[i+1].Centros[PosCentro].Cantidad;
		}	
		Dataset["label"]=arrCentros[PosCentro].Nombre;
    	Dataset["borderColor"]=PaletaColores[PosCentro];
    	Dataset["backgroundColor"]="#EEEEEE";
    	Dataset["fill"]=false;
		Datasets.push(Dataset);
	}
	else
	{
		//	Bucle sobre centros/categorias cuando corresponda
		for (var c=0;c<arrCentros.length;++c)
		{
			if (arrCentros[c].Lineas.length>0)
			{
				var Dataset= [];
				Dataset["data"]=[];	
				for (var i=0;i<arrEntradasMes.length-1;++i)
				{
					//	El array arrEntradasMes empieza en 1, labels y data en 0
					Dataset["data"][i]=arrEntradasMes[i+1].Centros[c].Cantidad;
				}	
				Dataset["label"]=arrCentros[c].Nombre;
    			Dataset["borderColor"]=PaletaColores[c];
    			Dataset["backgroundColor"]="#EEEEEE";
    			Dataset["fill"]=false;
				Datasets.push(Dataset);

			}
		}
	}

	if (document.getElementById("actMensual"))
	{
    	var ctx = document.getElementById("actMensual").getContext('2d');

		if (myChart)
        	myChart.destroy();

    	myChart = new Chart(ctx, {
        	type: 'line',
        	data: {
            	labels: Labels,
				borderColor: PaletaColores,
            	datasets: Datasets,
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


//	Abrimos la pagina de analisis de pedidos filtrada por el producto actual
function AnalisisPedidos(IDProducto)
{
	document.location="http://www.newco.dev.br/Personal/BandejaTrabajo/AnalisisPedidos2022.xsql?IDPRODUCTO="+IDProducto;
}

//	Abrimos la pagina de historico de compras del productos
function HistoricoTarifas(IDProducto, IDEmpresa)
{
	document.location="http://www.newco.dev.br/Gestion/EIS/HistoricoTarifasProducto2022.xsql?IDPRODUCTO="+IDProducto+'&IDEMPRESA='+IDEmpresa;
}

