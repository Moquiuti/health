//	JS para el envio de nuevas licitaciones via ajax a la plataforma medicalvm.com
//	ultima revision ET 11jun19 12:09

//	Contiene mucho código de depuración

var ficID;
var ficIDLicitacion;
var ficIDSeleccion;

var licStatus='OK';

var ficError='';
//var licLineaError='';

var ficControlErrores='';
//var LineaError='';

var ficProductos	= new Array();
//15may17	var	licNumProductosEnviados;

var	posCodPed=-1,
	posCodCenFac=-1,
	posCodProv=-1,
	posCodProd=-1,
	posCant=-1,
	posUdBasica=-1,
	posCodCenEnt=-1,
	posCodLugEnt=-1,
	posCodCenCoste=-1,
	posDescripcion=-1,
	posPrecio=-1,
	posLinea=-1,
	posMarca=-1;

var ficCamposCabecera= new Array();
var LineasCabecera;

//	2abr19 Inicializa los campos de la página
function Inicio()
{
	var Modelo;
	
	
	if (str_CabeceraFicPedidos==='')
	{
		//	Si no está informada la cabecera, valores por defecto
		LineasCabecera=0;
	}
	else
	{
		//	Prepara el array con los campos
		for (var i=0;i<=PieceCount(str_CabeceraFicPedidos,'|');++i)
		{
			var Cadena=Piece(str_CabeceraFicPedidos,'|',i);
			
			var Tipo=Piece(Cadena,'#',0);

			//'LINEASCABECERA#9|CODCENTROFACTURA#5#8|CODPEDIDO#6#80'			
			if (Tipo==='LINEASCABECERA')
			{
				LineasCabecera=Piece(Cadena,'#',1);
			}
			else
			{	
				var items		= [];
				items['Tipo']=Tipo;
				items['Fila']=Piece(Cadena,'#',1);
				items['Columna']=Piece(Cadena,'#',2);
				
				//solodebug
				console.log('Inicio. Nuevo Item('+i+'):'+items['Tipo']+','+items['Fila']+','+items['Columna']);

		 		ficCamposCabecera.push(items);
			}
		}
	}
	
	
	if (str_ModeloFicPedidos!='')
	{
		Modelo=str_ModeloFicPedidos;
		
		//	Prepara el array con los campos
		for (var i=0;i<=PieceCount(Modelo,'|');++i)
		{
			var Cadena=Piece(Modelo,'|',i);
				
			//solodebug
			console.log('Inicio. Nueva columna('+i+'):'+Cadena);

			
			//CODPEDIDO|CODCENTROFACTURA|CODPROVEEDOR|CODPRODUCTO|CANTIDAD|UNIDADBASICA|CODCENTROENTREGA|CODLUGARENTREGA
			switch (Cadena)
			{
				case 'CODPEDIDO':
					posCodPed=i;
					break;
				case 'CODCENTROFACTURA':
					posCodCenFac=i;
					break;
				case 'CODPROVEEDOR':
					posCodProv=i;
					break;
				case 'CODPRODUCTO':
					posCodProd=i;
					break;
				case 'CANTIDAD':
					posCant=i;
					break;
				case 'UNIDADBASICA':
					posUdBasica=i;
					break;
				case 'CODCENTROENTREGA':
					posCodCenEnt=i;
					break;
				case 'CODLUGARENTREGA':
					posCodLugEnt=i;
					break;
				case 'LINEA':
					posLinea=i;
					break;
				case 'PRODUCTO':
					posDescripcion=i;
					break;
				case 'MARCA':
					posMarca=i;
					break;
			}
			
		}

	}
	else
	{
		if (usMulticentros=='S')
		{
			Modelo=str_ModeloFicEstandarMulticentro;
			//posCodPed=-1;
			posCodCenFac=0;
			//posCodProv=-1;
			posCodProd=1;
			posCant=2;
			//posUdBasica=-1;
			//posCodCenEnt=-1;
			posCodLugEnt=3;
			posCodCenCoste=4;
			posDescripcion=5;
			posPrecio=6;
			//posLinea=-1;
			//posProducto=-1;
			//posMarca=-1;
		}
		else
		{
			Modelo=str_ModeloFicEstandarComprador;
			//posCodPed=-1;
			//posCodCenFac=-1;
			posCodProv=-1;
			posCodProd=0;
			posCant=1;
			//posUdBasica=-1;
			//posCodCenEnt=-1;
			posCodLugEnt=2;
			posCodCenCoste=3;
			posDescripcion=4;
			posPrecio=5;
			//posLinea=-1;
			//posProducto=-1;
			//posMarca=-1;
		}
	}

	jQuery("#MODELOCARGA").html(Modelo.replace(/\|/g, str_SeparadorFicPedidos));	
}



//	2ene17	recuperamos los datos de ofertas de un proveedor
function prepararEnvio(nombreFichero, ficRequisicao, ficTituloPdc, ficDataVencimento, ficHoraVencimento, ficMoeda, ficObservacao, ficUrgencia)
{
	var d= new Date();
	
	var datosFichero='Titulo_Pdc:'+ficTituloPdc+'|'
				+'Data_Vencimento:'+ficDataVencimento+'|'
				+'Hora_Vencimento:'+ficHoraVencimento+'|'
				+'Moeda:'+ficMoeda+'|'
				+'Observacao:'+ficObservacao+'|'
				+'Urgencia:'+ficUrgencia;

	//	Inicializamos las variables globales
	ficID='';
	ficIDLicitacion='';
	ficIDSeleccion='';

	licStatus='OK';

	ficError='';
	//licLineaError='';

	
	jQuery.ajax({
		cache:	false,
		async: false,
		url:	'http://www.newco.dev.br/Gestion/AdminTecnica/PrepararEnvioFichero.xsql',
		type:	"GET",
		data:	"NOMBRE="+nombreFichero+'&CODIGOCLIENTE='+ficRequisicao+"&DATOSFICHERO="+datosFichero+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			ficError='ERROR_CONECTANDO';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			//	Envio correcto de datos

			//solodebug
			//solodebug	console.log('prepararEnvioFichero: '+objeto);
			//solodebug	ficID=1;
			
			console.log('prepararEnvioFichero ficID:'+data.PrepararEnvio.IDFichero);
			
			ficID=data.PrepararEnvio.IDFichero;
		}
	});
}


//	Enviamos todos los productos al servidor
function EnviarTodosProductos(licNumProductosEnviados)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosProductos INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

	//	Entrada en el proceso
	
	//solodebug
	console.log('enviarLineaFichero: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length);

	if (licNumProductosEnviados>=ficProductos.length)
	{

		if (ficControlErrores==0)
		{
			//solodebug	console.log('enviarLineaFichero: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length + ' -> cerrarFichero sin errores');
			
			cerrarFichero(licNumProductosEnviados, 'OK');
			jQuery('#infoProgreso').html(str_FicheroProcesado);
			jQuery('#infoProgreso').show();
			jQuery('#infoErrores').hide();
			jQuery('#EnviarPedidoDesdeTexto').show();
			
			//reactivar 	
			location.reload(true);

			return 'OK';
		}
		else
		{
			//solodebug	
			console.log('enviarLineaFichero: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length + ' -> cerrarFichero CON ERROR');
			cerrarFichero(licNumProductosEnviados, 'ERROR');
			jQuery('#infoProgreso').hide();
			jQuery('#infoErrores').html(ficControlErrores);
			jQuery('#infoErrores').show();
			jQuery('#EnviarPedidoDesdeTexto').show();
			return 'ERROR';
		}
	}
	//solodebug
	//else
	//{
	//	console.log('enviarLineaFichero: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length+ ' => enviando');
	//}

	var texto	=licNumProductosEnviados+'/'+ficProductos.length+': ['+ficProductos[licNumProductosEnviados].Codigo+'] '+ficProductos[licNumProductosEnviados].Descripcion+': '+ficProductos[licNumProductosEnviados].Cantidad;
	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	'http://www.newco.dev.br/Gestion/AdminTecnica/EnviarProducto.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID+"&NUMLINEA="+licNumProductosEnviados+"&REFCLIENTE="+ficProductos[licNumProductosEnviados].Codigo+"&CANTIDAD="+ficProductos[licNumProductosEnviados].Cantidad+"&TIPOIVA="+"0"
					+"&LUGARENTREGA="+ficProductos[licNumProductosEnviados].LugarEntrega
					+"&CENTROCOSTE="+ficProductos[licNumProductosEnviados].CentroCoste
					+"&NOMBREPRODUCTO="+encodeURIComponent(ficProductos[licNumProductosEnviados].Descripcion)
					+"&ENTREGAS="+encodeURIComponent(ficProductos[licNumProductosEnviados].Entregas)
					+"&CAMPOS_EXTRA="+encodeURIComponent(ficProductos[licNumProductosEnviados].CamposExtra)
					+"&NIF_CENTRO="+encodeURIComponent(ficProductos[licNumProductosEnviados].NifCentro)
					+"&PRECIO="+encodeURIComponent(ficProductos[licNumProductosEnviados].Precio)
					+"&UDBASICA="+encodeURIComponent(ficProductos[licNumProductosEnviados].UdBasica)
					+"&CODPEDIDO="+encodeURIComponent(ficProductos[licNumProductosEnviados].CodPed)
					+"&CENTROENTREGA="+encodeURIComponent(ficProductos[licNumProductosEnviados].CodCenEnt)
					+"&PROVEEDOR="+encodeURIComponent(ficProductos[licNumProductosEnviados].CodProv)
					+"&MARCA="+encodeURIComponent(ficProductos[licNumProductosEnviados].Marca)
					+"&TEXTO="+encodeURIComponent(texto)+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			ficError='ERROR_ENVIANDO';
			//licLineaError=numLineaInicio;
			
			ficControlErrores+=ficControlErrores+str_NoPodidoIncluirProducto+': ('+ficProductos[licNumProductosEnviados].Codigo+') '+ficProductos[licNumProductosEnviados].Descripcion+'<br/>';
			console.log('enviarLineaFichero: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length+ ' => ERROR enviando:'+quepaso);
			return 'ERROR';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			
			//
			//	Control de errores en la funcion que llama a esta
			//
						
			ficIDSeleccion=	data.Producto.IDSeleccion;
			ficProductos[licNumProductosEnviados].IDProductoLic=data.Producto.IDProductoLic;

			//	debug
			console.log('enviarLineaFichero: res:'||data.Producto.estado);
			
			//	Procesar error
			if (data.Producto.estado=='ERROR')
			{
				console.log('enviarLineaFichero ERROR ENVIANDO: ('+ficProductos[licNumProductosEnviados].Codigo+') '+ficProductos[licNumProductosEnviados].Descripcion);
				ficError='ERROR_ENVIANDO';
				ficControlErrores+=str_NoPodidoIncluirProducto+': ('+ficProductos[licNumProductosEnviados].Codigo+') '+ficProductos[licNumProductosEnviados].Descripcion+'<br/>';
				licNumProductosEnviados=licNumProductosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumProductosEnviados].Codigo+') '+ficProductos[licNumProductosEnviados].Descripcion);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumProductosEnviados=licNumProductosEnviados+1;
			}

			//console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumProductosEnviados].Codigo+') '+ficProductos[licNumProductosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumProductosEnviados=licNumProductosEnviados+1;
			EnviarTodosProductos(licNumProductosEnviados);		

		}
	});
	
}

//	10feb17 Separamos la creación de la licitación de la preparación del envío
function cerrarFichero(numLineas, estado)
{
	var d= new Date();

	//solodebug	
	console.log('cerrarFichero: numlineas:'+numLineas+ ' estado:'+estado);
		
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	'http://www.newco.dev.br/Gestion/AdminTecnica/FinEnvioFichero.xsql',
		type:	"GET",
		data:	"IDFICHERO="+ficID+"&NUMLINEAS="+numLineas+"&ESTADO="+estado+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			ficError='ERROR_CONECTANDO';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			//	Envio correcto de datos

			//solodebug
			//solodebug	
			console.log('cerrarFichero: '+objeto);
			//solodebug	ficID=1;
			
			console.log('cerrarFichero ficID:'+data.Licitacion.IDLicitacion);
			
			//ficIDLicitacion=data.Licitacion.IDLicitacion;
			//ficID
		}
	});
}

//
//	Bloque principal del código para procesar un fichero en formato "XML ESTANDAR BRASIL"
//
function ProcesarFicheroXMLEstandarBrasil(fileName, fileContent)
{
	// Cuando éste evento se dispara, los datos están ya disponibles.
	//var output = document.getElementById("fileOutput");
	console.log('ProcesarFicheroXMLEstandarBrasil '+fileName+':'+fileContent);

	//	Datos generales de la licitacion
	var ficRequisicao, ficTituloPdc, ficDataVencimento, ficHoraVencimento, ficMoeda, ficObservacao, ficUrgencia, licAvisosCarga='', ficControlErrores=''; 

	//	Variables de uso interno
	var count=0;
	var textoSalida='';

	jQuery('#infoProgreso').html('Inicio: preparando licitación a partir de XML estándar Brasil.');
	//$('#infoProgreso').redraw();


	//	26may17 Pasamos a utilizar la librería ObjTree.js		
	try
	{
		var fileCorr=fileContent.replace(/&/g,'&amp;')
        var xotree = new XML.ObjTree();             
        var tree   = xotree.parseXML(fileCorr);
		
		
		console.log('Leyendo cabecera');
		//	recuperamos datos generales de la licitacion
		ficRequisicao=tree.Pedido.Cabecalho.Requisicao;
		ficTituloPdc=tree.Pedido.Cabecalho.Titulo_Pdc;
		ficDataVencimento=tree.Pedido.Cabecalho.Data_Vencimento;
		ficHoraVencimento=tree.Pedido.Cabecalho.Hora_Vencimento;
		ficMoeda=tree.Pedido.Cabecalho.Moeda;
		ficObservacao=tree.Pedido.Cabecalho.Observacao;
		//	Campos extra a nivel de licitacion
		//	ficUrgencia=tree.Pedido.Cabecalho.Campo_Extra.Nome;

		textoSalida='Requisicao:'+ficRequisicao+'<br/>'
				+' Titulo_Pdc:'+ficTituloPdc+'<br/>'
				+' Data_Vencimento:'+ficDataVencimento+'<br/>'
				+' Hora_Vencimento:'+ficHoraVencimento+'<br/>'
				+' Moeda:'+ficMoeda+'<br/>'
				+' Observacao:'+ficObservacao+'<br/>'
				+' Urgencia:'+ficUrgencia+'<br/>'+'<br/>';

		//solodebug
		console.log('Cabecera:'+textoSalida);
		textoSalida+='<br/>';
		
		
		//
		//	9oct17	En el caso de un único producto lo tratamos directamente
		//
		if (!Array.isArray(tree.Pedido.Itens_Requisicao.Item_Requisicao))
		{

			//solodebug	
			console.log('Recuperando un único producto del XML');
			
			var items		= [];
			items['Codigo']	= tree.Pedido.Itens_Requisicao.Item_Requisicao.Codigo_Produto;
			items['Descripcion'] = tree.Pedido.Itens_Requisicao.Item_Requisicao.Descricao_Produto;
			items['Cantidad'] = tree.Pedido.Itens_Requisicao.Item_Requisicao.Quantidade;
			items['IDProductoLic']	=0;		//	Pendiente de inicializar
			items['NifCentro']	= '';
			items['Precio']	= '';
			//	3abr19 Nuevos campos requeridos por la integración con Recoletas
			items['CodPed']	= '';
			items['LugarEntrega'] = '';		
			items['CentroCoste'] = '';		
			items['UdBasica'] = '';
			items['CodCenEnt'] = '';
			items['CodProv'] = '';
			items['CamposExtra'] = '';
			//	11jun19 Nuevos campos requeridos para la integración con Unimed
			items['Linea'] = '';
			items['Producto'] = '';
			items['Marca'] = '';


			//	1jun17 COmprobamos que la cantidad sea un número entero
			if (items['Cantidad'].indexOf(',')!=-1)
			{
				var CantidadOld=items['Cantidad'];
				items['Cantidad']=String(parseInt(items['Cantidad'].replace(",","."))+1);
				licAvisosCarga += items['Codigo']+': '+items['Descripcion']+'. '+str_CambioCantidad.replace('[[CANTIDADOLD]]',CantidadOld).replace('[[CANTIDADNEW]]',items['Cantidad']) +'\n\r';
			}


			//	24may17, Recuperar la programacion de entregas
			//items['Entregas']= new Array();

			//	Programacion entregas
			try
			{
				if (tree.Pedido.Itens_Requisicao.Item_Requisicao.Programacao_Entrega.length>0)
				{
					items['Entregas'] = '';
					for (j=0;j<tree.Pedido.Itens_Requisicao.Item_Requisicao.Programacao_Entrega.length;++j)
					{

						items['Entregas']+=tree.Pedido.Itens_Requisicao.Item_Requisicao.Programacao_Entrega[j].Data+'|'+tree.Pedido.Itens_Requisicao.Item_Requisicao.Programacao_Entrega[j].Quantidade+'#';

					}

				}
				else
				{
					items['Entregas']=tree.Pedido.Itens_Requisicao.Item_Requisicao.Programacao_Entrega.Data+'|'+tree.Pedido.Itens_Requisicao.Item_Requisicao.Programacao_Entrega.Quantidade;
				}
			}
			catch(err)
			{
				items['Entregas']='';
			}

			//	26may17, Recuperar campos extra
			items['CamposExtra']= new Array();

			//	Campos extra
			try
			{
				if (tree.Pedido.Itens_Requisicao.Item_Requisicao.Campo_Extra.length>0)
				{
					for (j=0;j<tree.Pedido.Itens_Requisicao.Item_Requisicao.Campo_Extra.length;++j)
					{
						items['CamposExtra']+=tree.Pedido.Itens_Requisicao.Item_Requisicao.Campo_Extra[j].Nome+'|'+tree.Pedido.Itens_Requisicao.Item_Requisicao.Campo_Extra[j].Valor+'#';
					}

				}
				else
				{
					items['CamposExtra']=tree.Pedido.Itens_Requisicao.Item_Requisicao.Campo_Extra.Nome+'|'+tree.Pedido.Itens_Requisicao.Item_Requisicao.Campo_Extra.Valor;
				}
			}
			catch(err)
			{
				items['CamposExtra']='';
			}

 			ficProductos.push(items);

			//solodebug
			console.log('Leyendo producto: ('+items['Codigo']+') '+items['Descripcion']+'. Cant:'+items['Cantidad']);

			if (licAvisosCarga!='') alert(licAvisosCarga);
		}
		
		
		
		
		
		//
		//	En el caso de múltiples productos recorremos el array
		//
		if (tree.Pedido.Itens_Requisicao.Item_Requisicao.length>0)
		{

			//	A partir del nodo de productos, recuperamos los datos de cada nodo
			for (i=0;i<tree.Pedido.Itens_Requisicao.Item_Requisicao.length;++i)
			{
				var items		= [];
				items['Codigo']	= tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Codigo_Produto;
				items['Descripcion'] = tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Descricao_Produto;
				items['Cantidad'] = tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Quantidade;
				items['IDProductoLic']	=0;		//	Pendiente de inicializar
				items['NifCentro']	= '';
				items['Precio']	= '';
				//	3abr19 Nuevos campos requeridos por la integración con Recoletas
				items['CodPed']	= '';
				items['LugarEntrega'] = '';		
				items['CentroCoste'] = '';		
				items['UdBasica'] = '';
				items['CodCenEnt'] = '';
				items['CodProv'] = '';
				items['CamposExtra'] = '';
				//	11jun19 Nuevos campos requeridos para la integración con Unimed
				items['Linea'] = '';
				items['Producto'] = '';
				items['Marca'] = '';


				//	1jun17 COmprobamos qeu la cantidad sea un número entero
				if (items['Cantidad'].indexOf(',')!=-1)
				{
					var CantidadOld=items['Cantidad'];
					items['Cantidad']=String(parseInt(items['Cantidad'].replace(",","."))+1);
					licAvisosCarga += items['Codigo']+': '+items['Descripcion']+'. '+str_CambioCantidad.replace('[[CANTIDADOLD]]',CantidadOld).replace('[[CANTIDADNEW]]',items['Cantidad']) +'\n\r';
				}


				//	24may17, Recuperar la programacion de entregas
				//items['Entregas']= new Array();

				//	Programacion entregas
				try
				{
					if (tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega.length>0)
					{
						items['Entregas'] = '';
						for (j=0;j<tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega.length;++j)
						{

							items['Entregas']+=tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega[j].Data+'|'+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega[j].Quantidade+'#';

						}

					}
					else
					{
						items['Entregas']=tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega.Data+'|'+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega.Quantidade;
					}
				}
				catch(err)
				{
					items['Entregas']='';
				}

				//	26may17, Recuperar campos extra
				items['CamposExtra']= new Array();

				//	Campos extra
				try
				{
					if (tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra.length>0)
					{
						for (j=0;j<tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra.length;++j)
						{
							items['CamposExtra']+=tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra[j].Nome+'|'+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra[j].Valor+'#';
						}

					}
					else
					{
						items['CamposExtra']=tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra.Nome+'|'+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra.Valor;
					}
				}
				catch(err)
				{
					items['CamposExtra']='';
				}

 				ficProductos.push(items);

				//solodebug
				console.log('Leyendo producto: ('+items['Codigo']+') '+items['Descripcion']+'. Cant:'+items['Cantidad']);

			}
			if (licAvisosCarga!='') alert(licAvisosCarga);

		}

		
		if (ficProductos.length==0)
			textoSalida+='No se han encontrado productos.<br/>';
		else
			textoSalida+='<br/>Num.productos:'+ficProductos.length+'<br/>';
		
		//	solodebug
		//for  (i=0;i<ficProductos.length;++i)
		//	textoSalida+='Linea '+i+' cod:'+ficProductos[i].Codigo+' nombre:'+ficProductos[i].Descripcion+' cant.:'+ ficProductos[i].Cantidad
		//		+' entregas.:'+ ficProductos[i].Entregas.length+' extra.:'+ficProductos[i].CamposExtra.length+'<br/>';
	}
	catch(err)
	{
		ficControlErrores='Formato XML incorrecto.';
	}


	//	Control de errores en el proceso
	if (ficControlErrores=='')
	{
		document.getElementById("infoProgreso").innerHTML = str_CreandoLicitacion+': '+fileName;
		jQuery('#infoProgreso').show();
		
		//	solodebug	alert(str_CreandoLicitacion+': '+fileName);
		
		ficControlErrores=EnviarFichero(fileName, ficIDLicitacion, ficRequisicao, ficTituloPdc, ficDataVencimento, ficHoraVencimento, ficMoeda, ficObservacao, ficUrgencia, ficProductos);
	}
	else
	{
		alert(ficControlErrores);
	}
}


//	3mar17	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
function EnviarFichero(fileName, ficIDLicitacion, ficRequisicao, ficTituloPdc, ficDataVencimento, ficHoraVencimento, ficMoeda, ficObservacao, ficUrgencia, ficProductos)
{
	var ficControlErrores='';
	
	//	8abr19	Faltaba inicializar el array de productos
	ficProductos	= new Array();

	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: '+fileName;
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvio(fileName, ficRequisicao, ficTituloPdc, ficDataVencimento, ficHoraVencimento, ficMoeda, ficObservacao, ficUrgencia);

	//	Control de errores: -1 No se ha podido crear
	if (ficID==-1)
	{
		ficControlErrores+=str_ErrorDesconocidoCreandoFichero;
	}

	//	Control de errores: -2 fichero ya existe
	if (ficID==-2)
	{
		ficControlErrores+=str_FicheroYaEnviado;
	}


	//	Paso 2: Enviar productos
	if (ficControlErrores=='')
	{
		
		//	Version recursiva
		//licNumProductosEnviados=0;
		EnviarTodosProductos(0);
		
	}
	else
	{
		document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: '+fileName+' ERROR:'+ficControlErrores;
	}

	return ficControlErrores;
}




//	15mar19 Prepara la recuperación de fichero de disco y el envío según opción seleccionada
function EnviarFicheroPedido(files)
{
	//	Inicia la carga del fichero
	var file = files[0];

	var reader = new FileReader();

	reader.onload = function (e) {
		
		console.log('Contenido fichero '+file.name);
		ProcesarCadenaPedidoTXT(e.target.result)
	};

	reader.readAsText(file);
	
}


//	21jun17	Extraemos los datos desde un areatext
function ProcesarCadenaTXT()
{
	var oForm = document.forms['SubirDocumentos'];
	ProcesarCadenaPedidoTXT(oForm.elements['TXT_PRODUCTOS'].value);
}


//	21jun17	Extraemos los datos desde un areatext
function ProcesarCadenaPedidoTXT(ListaProductos)
{
	var d= new Date();
	var Cambios=false, Modificados=0, NoEncontrados=0, RefNoEncontradas='', Control='';
	var licAvisosCarga ='';
	
	jQuery("#EnviarPedidoDesdeTexto").hide();
	
	//solodebug	var Control='';
	
	var Referencias	= ListaProductos.replace(/(?:\r\n|\r|\n)/g, '·');
	if (str_SeparadorFicPedidos!='')
	{
		var re = new RegExp(str_SeparadorFicPedidos, 'g');
		var Referencias	= Referencias.replace(re, '|');
	}
	else
	{
		var Referencias	= Referencias.replace(/[\t:]/g, '|');	
	}
	
	var numRefs	= PieceCount(Referencias, '·');
	
	//solodebug		alert('rev.25mar19 12:11\n\r'+Referencias+' numlineas:'+numRefs);
	
	ficControlErrores ='';
	
	//	8abr19	Faltaba inicializar el array de productos
	ficProductos	= new Array();
	
	var NifCentroGl='',CodPedGl='';
	for (i=0;i<=numRefs;++i)
	{
		var NifCentro='',Ref,Cantidad,LugarEntrega='',CentroCoste='',Descripcion='',Precio='',UdBasica='',CodCenEnt='',CodProv='',CodPed='',Linea='',Producto='',Marca='';
		var Producto	= Piece(Referencias, '·',i);
		

		if (i<LineasCabecera)
		{
			//solodebug	console.log('ProcesarCadenaPedidoTXT. Procesando cabecera('+i+'):'+Producto) ;
			
			for (var j=0;j<ficCamposCabecera.length;++j)
			{

				//solodebug	console.log('ProcesarCadenaPedidoTXT. Procesando cabecera('+i+'):'+Producto+ ' Comprobando:'+ficCamposCabecera[j].Tipo+ ' Fila:'+ficCamposCabecera[j].Fila);

				//	Comprueba si hay algún campo asociado a esta línea
				//	CUIDADO: cambiar algoritmo por si hay varios
				if (ficCamposCabecera[j].Fila==i)
				{
					//solodebug		console.log('ProcesarCadenaPedidoTXT. Procesando cabecera('+i+'):'+Producto+ ' Encontrado:'+ficCamposCabecera[j].Tipo+ ' Valor:'+ Piece(Producto,':',j));
					
					if (ficCamposCabecera[j].Tipo=='CODCENTROFACTURA')
					{
						NifCentroGl=Piece(Producto,'|',ficCamposCabecera[j].Columna);

						//solodebug
						console.log('ProcesarCadenaPedidoTXT. Procesando cabecera('+i+'):'+Producto+ ' NifCentro:'+NifCentroGl);
					}
					else if (ficCamposCabecera[j].Tipo=='CODPEDIDO')
					{
						CodPedGl=Piece(Producto,'|',ficCamposCabecera[j].Columna);

						//solodebug
						console.log('ProcesarCadenaPedidoTXT. Procesando cabecera('+i+'):'+Producto+ ' CodPed:'+CodPedGl);
					}
					
				}
			}
			
		}
		else
		{
			//solodebug
			console.log('ProcesarCadenaPedidoTXT. Oferta ('+i+'). NifCentro:'+NifCentroGl+ ' CodPed:'+CodPedGl);
			
			//solodebug	alert('['+Producto+']');
			if (posCodPed>=0) CodPed= Piece(Producto, '|', posCodPed);
			else CodPed= CodPedGl;
			
			if (posCodCenFac>=0) NifCentro= Piece(Producto, '|', posCodCenFac);
			else NifCentro= NifCentroGl;
			
			if (posCodProv>=0) CodProv= Piece(Producto, '|', posCodProv);
			if (posCodProd>=0) Ref= Piece(Producto, '|', posCodProd);
			if (posCant>=0) Cantidad= Piece(Producto, '|', posCant);
			if (posUdBasica>=0) UdBasica= Piece(Producto, '|', posUdBasica);
			if (posCodCenEnt>=0) CodCenEnt= Piece(Producto, '|', posCodCenEnt);
			if (posCodLugEnt>=0) LugarEntrega= Piece(Producto, '|', posCodLugEnt);
			if (posCodCenCoste>=0) CentroCoste= Piece(Producto, '|', posCodCenCoste);
			if (posDescripcion>=0) Descripcion= Piece(Producto, '|', posDescripcion);
			if (posPrecio>=0) Precio= Piece(Producto, '|', posPrecio);
			if (posLinea>=0) Linea= Piece(Producto, '|', posLinea);
			if (posMarca>=0) Marca= Piece(Producto, '|', posMarca);


			//solodebug		
			console.log('ProcesarCadenaTXT. Oferta ('+i+'). NifCentro:'+NifCentro+' CodPed:'+CodPed+'. Ref:'+Ref+'. Cant:'+Cantidad+'. Entr:'+LugarEntrega+'. CenCoste:'+CentroCoste
				+'. Desc:'+Descripcion+'. Precio:'+Precio+'. UdBasica:'+UdBasica+'. CodCenEnt:'+CodCenEnt+'. CodProv:'+CodProv
				+'. Linea:'+Linea+'. Producto:'+Producto+'. Marca:'+Marca);

			if ((Ref!='')&&(Cantidad!='')&&(Cantidad!='0'))		//	15dic17	Eliminamos líneas sin ref o cantidad
			{
				var items		= [];
				items['CodPed']	= CodPed;
				items['NifCentro']	= NifCentro;
				items['Codigo']	= Ref;
				items['Descripcion'] = Descripcion;
				items['Cantidad'] = Cantidad.replace(".","");		//	4ene18	Eliminamos los puntos (separador de miles)
				items['LugarEntrega'] = LugarEntrega;		
				items['CentroCoste'] = CentroCoste;		
				items['Precio'] = Precio;
				items['UdBasica'] = UdBasica;
				items['CodCenEnt'] = CodCenEnt;
				items['CodProv'] = CodProv;
				items['Entregas'] = '';
				items['CamposExtra'] = '';
				items['Linea'] = '';
				items['Marca'] = '';
				items['IDProductoLic']	=0;		//	Pendiente de inicializar

				//	1jun17 COmprobamos qeu la cantidad sea un número entero
				if (items['Cantidad'].indexOf(',')!=-1)
				{
					var CantidadOld=items['Cantidad'];
					items['Cantidad']=String(parseInt(items['Cantidad'].replace(",","."))+1);
					licAvisosCarga += items['Codigo']+': '+items['Descripcion']+'. '+str_CambioCantidad.replace('[[CANTIDADOLD]]',CantidadOld).replace('[[CANTIDADNEW]]',items['Cantidad']) +'\n\r';
				}

 				ficProductos.push(items);

				//solodebug
				console.log('Leyendo Centro:'+items['NifCentro']+' > producto: ('+items['Codigo']+') '+items['Descripcion']+'. Cant:'+items['Cantidad']);

			}
			else
			{
				//solodebug
				console.log('Descartando línea en blanco:'+Producto);
			}

		}	//end if (i<=LineasCabecera)
	}	//	end for


	//	Inicializamos los datos generales
	ficRequisicao='';
	ficTituloPdc='Carga texto '+d.getDate()+'/'+d.getMonth()+'/'+d.getFullYear()+' '+d.toLocaleTimeString();
	ficDataVencimento='';
	ficHoraVencimento='';
	ficMoeda='';
	ficObservacao='';
	ficUrgencia='';
	fileName=ficTituloPdc;
	ficIDLicitacion='';


	//solodebug		
	console.log('ProcesarCadenaTXT. Titulo Fichero:'+ficTituloPdc);

	//	var aviso=alrt_AvisoOfertasActualizadas.replace('[[MODIFICADOS]]',Modificados).replace('[[NO_ENCONTRADOS]]',NoEncontrados+(NoEncontrados==0?".":":"+RefNoEncontradas))
	//alert(aviso);

	//	Control de errores en el proceso
	if (ficControlErrores=='')
	{
		document.getElementById("infoProgreso").innerHTML = str_CreandoLicitacion+': '+fileName;
		jQuery('#infoProgreso').show();
		
		//	solodebug	alert(str_CreandoLicitacion+': '+fileName);
		
		ficControlErrores=EnviarFichero(fileName, ficIDLicitacion, ficRequisicao, ficTituloPdc, ficDataVencimento, ficHoraVencimento, ficMoeda, ficObservacao, ficUrgencia, ficProductos);
	}
	else
	{
		alert(ficControlErrores);
	}

}











