//	Funciones de Javascript utilizadas en EISDatosHTML.js
//	ago10	ET - rev. 14abr11 12:39

//	Datos globales: matriz de datos del EIS, máximo 1000 lineas
var		NumLineas,						//	Numero de lineas de la tabla (la ultima contiene el total)
		IDGrupos=new Array(1000),	
		NombresGrupos=new Array(1000),	//	Nombre del grupo (linea)
		IDIndicadores=new Array(1000),	//	Indicador para cada linea de la tabla
		NombresIndicadores=new Array(1000),	//	Indicador para cada linea de la tabla
		Valores=new Array(13000),		//	Matriz de valores (Grupos * Meses)
		Colores=new Array(13000),		//	Matriz de colores (Grupos * Meses)
		Valor,
		NombresMeses=new Array(13),		//	Nombre de los meses
		Meses=new Array(13),			//	Mes para cada columna
		Annos=new Array(13),			//	Anno para cada columna
		Done='N',						//	Tabla ya calculada
		LineaActiva=new Array(1000),	//	Indica si la linea de la tabla está activa (y se mostrará) u oculta
		Errores='',						//	Control de errores
		ColumnaOrdenacion='',			//	Columna sobre la que se ordena
		Orden='',						//	ASC o DESC
		ColumnaOrdenada=new Array(1000);//	Indices ordenados de la columna de orden
		 		//indicador de position
		
//	Prepara los datos para ser enviados a la pagina con el gráfico Google correspondiente
function PrepararTablaDatos()
{
	var Enlace,
		form=document.forms[0],
		CampoIndicador,
		Len,
		count=-1,
		IDGrupoActual='',
		NombreGrupoActual='',
		IDIndicadorActual='',
		NombreIndicadorActual='',
		Errores='',
		LineaActual='';			//	16mar11
		

	//PresentaCampos(form);

	for (j=0;j<form.elements.length;j++)
	{
			
		//	Recorremos las lineas de datos, sin repetir las lineas
		if((form.elements[j].name.substring(0,4)=='ROW|')&&((Piece(form.elements[j].name,'|',1)!=IDIndicadorActual)||(Piece(form.elements[j].name,'|',2)!=IDGrupoActual)||(Piece(form.elements[j].name,'|',3)!=LineaActual)))
		{
			//	Comprueba si hay cambio de indicador
			if (Piece(form.elements[j].name,'|',1)!=IDIndicadorActual)
			{
				IDIndicadorActual=Piece(form.elements[j].name,'|',1);
				NombreIndicadorActual=form.elements["INDICADOR|"+IDIndicadorActual].value;
			}

			//	
			if (Piece(form.elements[j].name,'|',3)!=LineaActual)
			{
				LineaActual=Piece(form.elements[j].name,'|',3);
			}
			
			//	
			if (Piece(form.elements[j].name,'|',2)!=IDGrupoActual)
			{
				IDGrupoActual=Piece(form.elements[j].name,'|',2);
				NombreGrupoActual=form.elements["GRUPO|"+IDIndicadorActual+"|"+IDGrupoActual+'|'+LineaActual].value;
				if (IDGrupoActual!='99999Total') count=count+1;
			}
			
			
			//	Filtramos la linea de totales
			if (IDGrupoActual!='99999Total')
			{
				IDIndicadores[count]=IDIndicadorActual;
				NombresIndicadores[count]=NombreIndicadorActual;
				IDGrupos[count]=IDGrupoActual;
				NombresGrupos[count]=NombreGrupoActual;
				LineaActiva[count]='S';
				
				
				//	Recorremos todas las celdas de valores
				for (k=1;k<=13;k++)
				{
					
					//Valor=ANumero(form.elements['ROW|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+k].value);
					Valores[count*13+k-1]=ANumero(form.elements['ROW|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+LineaActual+'|'+k].value);
					//if (isNaN(Valores[count*13+k-1])) alert('ERROR! IDIndicadorActual:'+IDIndicadorActual+' IDGrupoActual:'+IDGrupoActual+' k:'+k+'\n');

					try
					{
						if (form.elements['ROW|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+LineaActual+'|'+k+'|COLOR'].value=='ROJO')
							Colores[count*13+k-1]='R';
						if (form.elements['ROW|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+LineaActual+'|'+k+'|COLOR'].value=='VERDE')
							Colores[count*13+k-1]='V';
						if (form.elements['ROW|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+LineaActual+'|'+k+'|COLOR'].value=='NEGRO')
							Colores[count*13+k-1]='N';
					}
					catch(err)
					{
						Colores[count*13+k-1]='?';
					}
				}
			}
		}
	}  
	NumLineas=count;

	// Montamos array de meses
	NombresMeses[0]='';
    for (j=1;j<=12;j++)
	{
        NombresMeses[j]=form.elements['NOMBREMES_'+j].value;
		Meses[j]=Piece(form.elements['MES_'+j].value,'/',0);
		Annos[j]=Piece(form.elements['MES_'+j].value,'/',1);
    }
	NombresMeses[13]='Total';
	Meses[13]='99';
	Annos[13]=form.elements['OR_ANNO'].value;

	//	Ordenación por defecto
	ColumnaOrdenacion='';
	Orden='';
	for (i=0; i<=NumLineas; i++) 
		ColumnaOrdenada[i]=i;

	Done='S';
	
	if (Errores!='') alert(Errores);		//solodebug!!!!
	//debugMatriz();							//solodebug: recuperamos la matriz y la mostramos en pantalla		
}

//	Muestra el contenido de la matriz de valores (para depuración)
function debugMatriz()
{	
	var Matriz='';
	//	Meses
	for (j=0;j<=13;j++)
	{
		Matriz=Matriz+NombresMeses[j]+':';
	}
	Matriz=Matriz+'\n';

	//	Valores
	for (j=0;j<=NumLineas;j++)
	{
		Matriz=Matriz+'['+LineaActiva[j]+' ord:'+ColumnaOrdenada[i]+']'+NombresGrupos[j]+':'+IDGrupos[j]+'|';	//+NombresIndicadores[j]+'('+IDIndicadores[j]+'):'
		for (k=0;k<=13;k++)
		{
			Matriz=Matriz+Valores[j*13+k]+':'+Colores[j*13+k]+'|';
		}
		Matriz=Matriz+'\n';
	}
	alert(Matriz);
}

function CompruebaLineasOcultas()
{
	for (j=0;j<=NumLineas;j++)
		if (LineaActiva[j]=='N') return 'S';
	return 'N';
}

function CompruebaLineasActivas()
{
	for (j=0;j<=NumLineas;j++)
		if (LineaActiva[j]=='S') return 'S';
	return 'N';
}

//	Devuelve los IDs de grupo de las lineas activas, separadas por '|'
function ListaLineasActivas()	
{
	var Res='';

	for (j=0;j<=NumLineas;j++)
		if (LineaActiva[j]=='S') 
			Res=Res+IDGrupos[j]+'|';
	return Res;
}

function MostrarPosiciones(){	//	Posiciones relativas de los conceptos
	var Enlace;
	var form=document.forms[0];

	Enlace='http://www.newco.dev.br/Gestion/EIS/EISPosiciones.xsql?'
			+'SES_ID='+form.elements['OR_SES_ID'].value
			+'&'+'IDCUADROMANDO='+form.elements['OR_IDCUADRO'].value
			+'&'+'ANNO='+form.elements['OR_ANNO'].value
			+'&'+'IDEMPRESA='+form.elements['OR_IDEMPRESA'].value
			+'&'+'IDCENTRO='+form.elements['OR_IDCENTRO'].value
			+'&'+'IDUSUARIO='+form.elements['OR_IDUSUARIOSEL'].value
			+'&'+'IDEMPRESA2='+form.elements['OR_IDEMPRESA2'].value
			+'&'+'IDPRODUCTO='+form.elements['OR_IDPRODUCTO'].value
			+'&'+'IDFAMILIA='+form.elements['OR_IDFAMILIA'].value
			+'&'+'IDESTADO='+form.elements['OR_IDESTADO'].value
			+'&'+'IDTIPOINCIDENCIA='+form.elements['OR_IDTIPOINCIDENCIA'].value
			+'&'+'IDGRAVEDAD='+form.elements['OR_IDGRAVEDAD'].value
			+'&'+'REFERENCIA='+form.elements['OR_REFERENCIA'].value
			+'&'+'CODIGO='+form.elements['OR_CODIGO'].value
			+'&'+'IDRESULTADOS='+form.elements['OR_IDRESULTADOS'].value
			+'&'+'AGRUPARPOR='+form.elements['OR_AGRUPARPOR'].value
			+'&'+'IDRATIO='+form.elements['OR_IDRATIO'].value;

	MostrarPag(Enlace, 'Posiciones');
}

//	Presenta la pagina con el listado correspondiente a la seleccion del usuario
//	Si hay lineas ocultas, pasar la lista de empresas concatenada
function MostrarListado(Indicador, Grupo, Anno, Mes)
{
	var Enlace;
	var form=document.forms[0];

	if ((Grupo=='99999Total') && (CompruebaLineasOcultas()=='S'))
		Cadena=ListaLineasActivas();
	else
		Cadena=Grupo;

	Enlace='http://www.newco.dev.br/Gestion/EIS/EISListado.xsql?'
			+'US_ID='+form.elements['OR_US_ID'].value
			+'&'+'IDINDICADOR='+Indicador
			+'&'+'ANNO='+Anno
			+'&'+'MES='+Mes
			+'&'+'IDEMPRESA='+form.elements['OR_IDEMPRESA'].value
			+'&'+'IDCENTRO='+form.elements['OR_IDCENTRO'].value
			+'&'+'IDUSUARIO='+form.elements['OR_IDUSUARIOSEL'].value
			+'&'+'IDEMPRESA2='+form.elements['OR_IDEMPRESA2'].value
			+'&'+'IDPRODUCTO='+form.elements['OR_IDPRODUCTO'].value
			+'&'+'IDFAMILIA='+form.elements['OR_IDFAMILIA'].value
			+'&'+'IDESTADO='+form.elements['OR_IDESTADO'].value
			+'&'+'IDTIPOINCIDENCIA='+form.elements['OR_IDTIPOINCIDENCIA'].value
			+'&'+'IDGRAVEDAD='+form.elements['OR_IDGRAVEDAD'].value
			+'&'+'REFERENCIA='+form.elements['OR_REFERENCIA'].value
			+'&'+'CODIGO='+form.elements['OR_CODIGO'].value
			//+'&'+'IDNOMENCLATOR='+
			//+'&'+'URGENCIA='+
			+'&'+'AGRUPARPOR='+form.elements['OR_AGRUPARPOR'].value
			+'&'+'IDGRUPO='+Cadena;		//	Grupo;

	MostrarPag(Enlace, 'Listado');
}


function HabilitarRatios(form,valor,dspOrigen, dspDestino){
  if(form.elements[dspOrigen].value==valor){
	form.elements[dspDestino].disabled=false;
  }
  else{
	form.elements[dspDestino].selectedIndex=0;
	form.elements[dspDestino].disabled=true;
  }
}


//
//	Funciones necesarias para el uso de gráficos
//

//	Busca un texto dentro del nombre de un campo
function BuscaCampo(form, Campo)
{
	var 	Nombre,
			Len=Campo.length;

	for (j=0;j<form.elements.length;j++)
	{
		if(form.elements[j].name.substring(0,Len)==Campo)
			Nombre=form.elements[j].name;
	}  

	return Nombre;
}


//	Elimina el punto de una cadena y convierte ',' a '.' para poder convertir a numero
function PreparaNumero(Cadena)
{
	var	Res='';

	//alert(Cadena);

	try
	{
		for (i=0;i<Cadena.length;++i)
		{
			if (Cadena.charAt(i)!='.')
			{
				if (Cadena.charAt(i)!=',')
					Res=Res+Cadena.charAt(i);
				else
					Res=Res+'.';
			}
		}
	}
	catch(err)
	{
		Errores=Errores+'PreparaNumero: parámetro vacio:'+err+'\n';
	}
	//alert(Res);
	return Res;
}


//	Elimina el punto de una cadena y convierte ',' a '.' para poder convertir a numero
function ANumero(Cadena)
{

	//alert(Cadena+'::'+PreparaNumero(Cadena)+'::'+parseFloat(PreparaNumero(Cadena))+'::'+parseFloat(Cadena));
	return(parseFloat(PreparaNumero(Cadena)));
}


//	Prepara los datos para ser enviados a la pagina con el gráfico Google correspondiente
function GraficoGoogle()
{

	if (Done=='N')	PrepararTablaDatos();

    //Creacion del grafico Google
	var data = new google.visualization.DataTable();

	data.addColumn('string', 'Clinicas');

    // Añadimos columnas - centros, nombres clinicas, etc., no el total
    for (i=0;i<=NumLineas;i++)
	{
		if (LineaActiva[i]=='S')
	        data.addColumn('number', NombresGrupos[i]);
    }

	// Añadimos el numero de rows
	data.addRows(12);

 	for (i=0;i<12;i++)
	{
        data.setValue(i, 0, NombresMeses[i+1]);

		var linea=1;	//	contamos lineas visibles
		for (l=0;l<=NumLineas;l++)
		{
			if (LineaActiva[l]=='S')
			{
			 	data.setValue(i, linea, Valores[l*13+i]);
				linea++;
			}
		}
	}	

	new google.visualization.LineChart(
		document.getElementById('graficoGoogle')).draw
		(
			data, 
			{
				smoothLine: true, 
				width: 800, 
				height: 400
			}
		);  		

}


//	EIS En blanco
function MostrarEISInicio()
{
	MostrarPag('http://www.newco.dev.br/Gestion/EIS/EISInicio.xsql', 'Consulta');
}

//	Solo para pruebas con XML -> Algunos parametros no se pueden modificar
function MostrarXML()
{
	var Enlace;
	var form=document.forms[0];

	Enlace='http://www.newco.dev.br/Gestion/EIS/EISDatosXML.xsql?'
			+'US_ID='+form.elements['OR_US_ID'].value
			+'&'+'IDCUADROMANDO='+form.elements['OR_IDCUADRO'].value
			+'&'+'ANNO='+form.elements['OR_ANNO'].value
			+'&'+'IDEMPRESA='+form.elements['OR_IDEMPRESA'].value
			+'&'+'IDCENTRO='+form.elements['OR_IDCENTRO'].value
			+'&'+'IDUSUARIO='+form.elements['OR_IDUSUARIOSEL'].value
			+'&'+'IDEMPRESA2='+form.elements['OR_IDEMPRESA2'].value
			+'&'+'IDPRODUCTO='+form.elements['OR_IDPRODUCTO'].value
			+'&'+'IDFAMILIA='+form.elements['OR_IDFAMILIA'].value
			+'&'+'IDESTADO='+form.elements['OR_IDESTADO'].value
			+'&'+'IDTIPOINCIDENCIA='+form.elements['OR_IDTIPOINCIDENCIA'].value
			+'&'+'IDGRAVEDAD='+form.elements['OR_IDGRAVEDAD'].value
			+'&'+'REFERENCIA='+form.elements['OR_REFERENCIA'].value
			+'&'+'CODIGO='+form.elements['OR_CODIGO'].value
			+'&'+'AGRUPARPOR='+form.elements['OR_AGRUPARPOR'].value
			+'&'+'IDRESULTADOS='+form.elements['OR_IDRESULTADOS'].value;

	MostrarPag(Enlace, 'Prueba');
}

//	Abre una pagina con la ficha del grupo seleccionado
function MostrarFichaAgrupacion(ID)
{
	var Enlace;
	var Presentar=true;
	var form=document.forms[0];

	switch (form.elements['OR_AGRUPARPOR'].value)
	{
		case 'EMP': Enlace='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?VENTANA=NUEVA&EMP_ID=';
					break;
		case 'EMP2': Enlace='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?VENTANA=NUEVA&EMP_ID=';
					break;
		case 'CEN': Enlace='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID=';
					break;
		case 'PRO': Enlace='http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=';
					break;
		case 'USU': Enlace='Usuario';
					Presentar=false;
					break;
		case 'REF': Enlace='Referencia';
					Presentar=false;
					break;
		case 'FAM': Enlace='Familia';
					Presentar=false;
					break;
		case 'EST': Enlace='Estado';
					Presentar=false;
					break;
		default:
			return;

	}
	//alert(Enlace+':'+form.elements['AGRUPARPOR'].value+':'+ID);

	if (Presentar==false)				
		alert('No hay una ficha definida agrupando por '+Enlace)
	else{
		  if(form.elements['OR_AGRUPARPOR'].value=='EMP2'){
		    MostrarPagPersonalizada(Enlace+ID,'Ficha',65,58,0,-50);
		  }
		  else{
		    if(form.elements['OR_AGRUPARPOR'].value=='PRO'){
		      MostrarPagPersonalizada(Enlace+ID,'Ficha',70,50,0,-50);
		    }
		    else{
		  MostrarPag(Enlace+ID, 'Ficha');
			}
	    }
		}
}

function VerDatos()
{
	$("#TablaDatos").show();
	$("#Grafico").hide();
	$("#SQL").hide();
	
	$("#datosEIS").hide;
	$("#graficoEIS").show;
	$("#sqlEIS").show;
}

function VerGrafico()
{
	GraficoGoogle();
	$("#Grafico").show();
	$("#TablaDatos").hide();
	$("#SQL").hide();
	
	$("#datosEIS").show;
	$("#graficoEIS").hide;
	$("#sqlEIS").show;
}

function VerSQL()
{
	$("#TablaDatos").hide();
	$("#Grafico").hide();
	$("#SQL").show();
	
	$("#datosEIS").show;
	$("#graficoEIS").show;
	$("#sqlEIS").hide;
}

//	Recorre los controles y activa los checkboxes de los Grupos
function Seleccionar(Valor)
{
	var form=document.forms[0];
	for (j=0;j<form.elements.length;j++)
	{
		if(form.elements[j].name.substring(0,12)=='CHECK_GRUPO|')
		{
			form.elements[j].checked=Valor;
		}
	}  
}

//	Marca los Indicadores/grupos que deben dejarse y vuelve a presentar la tabla
//	Valor=true:dejar, Valor=false:quitar
function Activar(Valor)
{
	var form=document.forms[0];
	
	if (Done=='N')	PrepararTablaDatos();
	for (j=0;j<form.elements.length;j++)
	{
		if(form.elements[j].name.substring(0,12)=='CHECK_GRUPO|')
		{
			var	IDIndicador=Piece(form.elements[j].name,'|',1);
			var	IDGrupo=Piece(form.elements[j].name,'|',2);
			var	Pos=BuscaPosicion(IDIndicador, IDGrupo);
			
			if (Valor==true)	//	DEJAR
				if (form.elements[j].checked==true){
					LineaActiva[Pos]='S';
					}
				else
					LineaActiva[Pos]='N';
			else				//	QUITAR
				if (form.elements[j].checked==true)
					LineaActiva[Pos]='N';
		}
	}  

	//	Si no hay lineas marcadas como activas no mostramos la tabla
	if (CompruebaLineasActivas()=='N')
	{
		alert('Es necesario que haya alguna línea activa');
		return;
	}

	//redibujar tabla
	generarTabla();
}

function TodasLineasActivas()
{
	for (i=0;i<=NumLineas;++i)
		LineaActiva[i]='S';

	//	Recargamos los datos originales
	Done='N';
	PrepararTablaDatos();

	//redibujar tabla
	generarTabla();
	
}

//	Busca a que linea se corresponde un par Indicador/Grupo 
function BuscaPosicion(IDIndicador, IDGrupo)
{
	var Pos=-1;

	for (i=0;i<=NumLineas;i++)
	{
		if ((IDIndicadores[i]==IDIndicador)&&(IDGrupos[i]==IDGrupo))
			Pos=i;
	}

	return Pos;
}


//	Prepara un array con los ordenes correspondientes a una columna	
//	PENDIENTE: separar ordenación segun indicador
function ordenamientoBurbuja(col, tipo) 
{
	for (i=0; i<=NumLineas; i++) 
		ColumnaOrdenada[i]=i;

	for (i=0; i<=NumLineas; i++) 
	{
		for (j=i+1; j<=NumLineas; j++) 
		{
 			if (Valores[ColumnaOrdenada[i]*13+col] > Valores[ColumnaOrdenada[j]*13+col]) 
			{
				temp=ColumnaOrdenada[j];
				ColumnaOrdenada[j]=ColumnaOrdenada[i];
				ColumnaOrdenada[i]=temp;
			}
		}	 
	}

	//	En caso de ordenación descendente intercambiamos de forma simétrica el vector de ordenación
	if (tipo=='DESC')
	{
		for (i=0; i<=NumLineas/2; i++)
		{
			temp=ColumnaOrdenada[NumLineas-i];
			ColumnaOrdenada[NumLineas-i]=ColumnaOrdenada[i];
			ColumnaOrdenada[i]=temp;
		}
	}

	//debug	var depurar='';
	//debug	for (i=0; i<=NumLineas; i++) 
	//debug		depurar=depurar+NombresGrupos[ColumnaOrdenada[i]]+':'+Valores[ColumnaOrdenada[i]*13+col]+'\n';
	//debug	
	//debug	alert('Ordenación:'+depurar);

}

//	Ordena por una columna
function OrdenarPorColumna(col)
{
	if (ColumnaOrdenacion==col)
	{
		if (Orden=='ASC')
			Orden='DESC';
		else
			Orden='ASC';
	}
	else
	{
		ColumnaOrdenacion=col;
		Orden='ASC';
	}

	//	Ordenar sobre esta columna
	ordenamientoBurbuja(col, Orden) 

	//	Redibujar tabla
	generarTabla();
}

//	Variables con cadenas necesarias para construir el HTML de las tablas
var cellTitleStart = '<td align="right">';
var cellTitleStartIndic = '<td align="left">';
var rowIndStart = '<tr class="subTituloTabla">';
var cellIndStart = '<td align="left" colspan="14">&nbsp;&nbsp;';
var rowStart = '<tr class="#CLASEPAROIMPAR#">';
var rowEnd = '</tr>';
var cellGroupStart = '&nbsp;<input type="checkbox" name="CHECK_GRUPO|#IDINDICADOR#|#IDGRUPO#"/>&nbsp;&nbsp;';
var cellTotalStart = '<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;';
var cellStart = '<td align="right">';
var cellEnd = '</td>';
var macroEnlaceGrupo='<a class="grupo" href="javascript:MostrarFichaAgrupacion(\'#IDGRUPO#\');">';
var macroEnlaceNormal='<a class="#CLASS#" href="javascript:MostrarListado(\'#IDINDICADOR#\',\'#IDGRUPO#\',\'#ANNO#\',\'#MES#\');">';


//	Genera de forma dinámica la tabla de datos del EIS
function generarTabla(){		
	//debugMatriz();		//solodebug!!!!

	var linea=0;
	var pos = 0;
	var HayOcultas='N';

	//	Total para cada indicador
	var Totales=new Array(13);
	for (k=1;k<=13;k++)  Totales[k]=0;

	var Clase;
	var cellStartThis;

	//var cadenaHtml='<table id="TablaDatos" width="100%" class="muyoscuro" border="0" align="center" cellspacing="1" cellpadding="3" >'
	var cadenaHtml='<tr class="titleTabla">';

	cadenaHtml=cadenaHtml+ cellTitleStartIndic + '&nbsp;&nbsp;Indicadores' +cellEnd;
	
	
	for (i=1;i<=13;i++)
	{
		if ((ColumnaOrdenacion==(i-1))&&(Orden!=''))
			if (Orden=='ASC')
				EnlaceImagen='<img src="http://www.newco.dev.br/images/order_a.gif" border="false"/>';
			else
				EnlaceImagen='<img src="http://www.newco.dev.br/images/order_d.gif" border="false"/>';
		else
			EnlaceImagen='<img src="http://www.newco.dev.br/images/ordenar.gif" border="false"/>';

        cadenaHtml=cadenaHtml+ cellTitleStart +'<a href="javascript:OrdenarPorColumna('+(i-1)+');">'+ NombresMeses[i]+'&nbsp;'+EnlaceImagen+'</a>'+cellEnd;
    }
	
	cadenaHtml=cadenaHtml+'<tr><td colspan="14"><table width="100%" class="azul"><tr class="subTituloTabla"><td width="5%">'+BotonHTML('Todos', 'Seleccionar todos', 'javascript:Seleccionar(true);', 50)+'</td><td width="5%">'+BotonHTML('Ninguno', 'Seleccionar ninguno', 'javascript:Seleccionar(false);', 50)+'</td><td width="5%">'+BotonHTML('Quitar', 'Quitar todos los seleccionados', 'javascript:Activar(false);', 50)+'</td><td width="5%">'+BotonHTML('Dejar', 'Dejar todos los seleccionados', 'javascript:Activar(true);', 50)+'</td><td width="10%">'+BotonHTML('Ver Ocultos', 'Ver todas las lineas de datos', 'javascript:TodasLineasActivas();', 100)+'</td><td width="70%">&nbsp;</td></tr></table></td></tr>';
	
	var IDIndicadorActual='';
	
	for (i=0;i<=NumLineas;i++){
		
		//	Comprueba si la linea está activa
		if (LineaActiva[ColumnaOrdenada[i]]=='S'){
			linea++;
			pos++;

			//	Comprueba cambio de Indicador
			if (IDIndicadorActual!=IDIndicadores[ColumnaOrdenada[i]])
			{
				//	Muestra la linea de totales correspondiente al indicador anterior
				if (IDIndicadorActual!='')
				{
					cadenaHtml=cadenaHtml+LineaTotalesHTML(IDIndicadorActual, Totales, linea, HayOcultas);

					//	Inicializa la linea de totales
					for (k=1;k<=13;k++)  Totales[k]=0;
				}
				pos=0;
				cadenaHtml=cadenaHtml+rowIndStart+cellIndStart+NombresIndicadores[ColumnaOrdenada[i]]+cellEnd+rowEnd;
				IDIndicadorActual=IDIndicadores[ColumnaOrdenada[i]];
			}

			cellStartThis=Replace(cellGroupStart,'#IDINDICADOR#',IDIndicadorActual);
			cellStartThis=Replace(cellStartThis,'#IDGRUPO#',IDGrupos[ColumnaOrdenada[i]]);
			//cellStartThis= linea+cellStartThis;
			//cellStartThis=Replace(cellStartThis,'#CLASEPAROIMPAR#',((linea%2)==0?'par':'impar'));
			
			//para enseñar
			if (pos < 10){
				pos = '0'+pos;
				}
			
			cadenaHtml=cadenaHtml+Replace(rowStart,'#CLASEPAROIMPAR#',((linea%2)==0?'par':'impar'))+'<td align="left">'+pos+cellStartThis+Replace(macroEnlaceGrupo,'#IDGRUPO#',IDGrupos[ColumnaOrdenada[i]])+NombresGrupos[ColumnaOrdenada[i]]+'</a>'+cellEnd;

			for (k=1;k<=13;k++)
			{
				Totales[k]=Totales[k]+Valores[ColumnaOrdenada[i]*13+k-1];

				Clase='celdanormal';
				if (k<13)
				{
					Enlace=macroEnlaceNormal;
					if(Colores[ColumnaOrdenada[i]*13+k-1]=='R')	Clase='celdaconrojo';	//cellStart=redCellStart;
					if(Colores[ColumnaOrdenada[i]*13+k-1]=='V')	Clase='celdaconverde';	//cellStart=greenCellStart;
				}
				else
					Enlace=macroEnlaceNormal;

				Enlace=Replace(Enlace,'#CLASS#',Clase);
				Enlace=Replace(Enlace,'#IDINDICADOR#',IDIndicadores[ColumnaOrdenada[i]]);
				Enlace=Replace(Enlace,'#IDGRUPO#',IDGrupos[ColumnaOrdenada[i]])
				//Enlace=Replace(Enlace,'#ANNOINICIO#',$('#OR_ANNO').value);
				Enlace=Replace(Enlace,'#ANNO#',Annos[k]);
				Enlace=Replace(Enlace,'#MES#',Meses[k]);

				//cellStartThis=Replace(cellStart,'#CLASEPAROIMPAR#',((linea%2)==0?'par':'impar'));
				
				//formatNumbre 
				//cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber( parseFloat(Valores[ColumnaOrdenada[i]*13+k-1]),0,',','.')+'</a>'+cellEnd;
				
				cadenaHtml=cadenaHtml+cellStart+Enlace+Valores[ColumnaOrdenada[i]*13+k-1]+'</a>'+cellEnd;
					
				//alert(cadenaHtml);
				//return false;
			}
			cadenaHtml=cadenaHtml+rowEnd;
		}
		else HayOcultas='S';
	}	
	
	
	cadenaHtml=cadenaHtml+LineaTotalesHTML(IDIndicadorActual, Totales, linea);
	

	cadenaHtml=cadenaHtml+'<tr><td colspan="14"><table width="100%" class="azul"><tr class="subTituloTabla"><td width="5%">'+BotonHTML('Todos', 'Seleccionar todos', 'javascript:Seleccionar(true);', 50)+'</td><td width="5%">'+BotonHTML('Ninguno', 'Seleccionar ninguno', 'javascript:Seleccionar(false);', 50)+'</td><td width="5%">'+BotonHTML('Quitar', 'Quitar todos los seleccionados', 'javascript:Activar(false);', 50)+'</td><td width="5%">'+BotonHTML('Dejar', 'Dejar todos los seleccionados', 'javascript:Activar(true);', 50)+'</td><td width="10%">'+BotonHTML('Ver Ocultos', 'Ver todas las lineas de datos', 'javascript:TodasLineasActivas();', 100)+'</td><td width="70%">&nbsp;</td></tr></table></td></tr>';
	
	
	$("#TablaDatos").html(cadenaHtml);
	
	

}




//	Genera la linea de totales
function LineaTotalesHTML(IDIndicador, Totales, linea, HayOcultas)
{
	var cadenaHtml;

	cellStartThis=Replace(cellTotalStart,'#IDINDICADOR#',IDIndicador);
	cellStartThis=Replace(cellStartThis,'#IDGRUPO#','99999Total');

	cadenaHtml=Replace(rowStart,'#CLASEPAROIMPAR#','medio')+cellStartThis+Replace(macroEnlaceGrupo,'#IDGRUPO#','99999Total')+'Total</a>'+cellEnd;

	for (k=1;k<=13;k++)
	{
		Enlace=macroEnlaceNormal;
		Enlace=Replace(Enlace,'#CLASS#','celdanormal');
		Enlace=Replace(Enlace,'#IDINDICADOR#',IDIndicador);
		Enlace=Replace(Enlace,'#IDGRUPO#','99999Total')
		Enlace=Replace(Enlace,'#ANNOINICIO#',$('#OR_ANNO').value);
		Enlace=Replace(Enlace,'#ANNO#',Annos[k]);
		Enlace=Replace(Enlace,'#MES#',Meses[k]);

		cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber( Totales[k],0,',','.')+'&nbsp;</a>'+cellEnd;
	}
	cadenaHtml=cadenaHtml+rowEnd

	return cadenaHtml;
}

//	Crea un botón HTML desde el javascript
function BotonHTML(texto, explicacion, funcion, ancho)
{
	var cadenaHtml='<table class="muyoscuro" border="0" cellpadding="1" cellspacing="1" width="'+ancho+'"><tr><td class="strongAzul" align="center" valign="middle"><a href="'+funcion+'" onmouseover="window.status=\''+explicacion+'\';return true;" onmouseout="window.status=\'\'; return true;">'+texto+'</a></td></tr></table>';
	return cadenaHtml;
}


//	Da formato a un numero decimal
function FormatNumber(number, decimals, dec_point, thousands_sep) 
{
    var n = !isFinite(+number) ? 0 : +number, 
        prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
        sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,        dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
        s = '',
        toFixedFix = function (n, prec) {
            var k = Math.pow(10, prec);
            return '' + Math.round(n * k) / k;        };
    // Fix for IE parseFloat(0.55).toFixed(0) = 0;
    s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
    if (s[0].length > 3) {
        s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);    }
    if ((s[1] || '').length < prec) {
        s[1] = s[1] || '';
        s[1] += new Array(prec - s[1].length + 1).join('0');
    }    return s.join(dec);
}


// needle may be a regular expression
function Replace(haystack, needle, replacement) 
{
	var r = new RegExp(needle, 'g');
	return haystack.replace(r, replacement);
}
