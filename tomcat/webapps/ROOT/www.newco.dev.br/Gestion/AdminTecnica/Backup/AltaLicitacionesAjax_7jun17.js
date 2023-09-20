//	JS para el envio de nuevas licitaciones via ajax a la plataforma medicalvm.com
//	ultima revision ET 8jun17 11:27

var licIDFichero;
var licIDLicitacion;
var licIDSeleccion;

var licStatus='OK';

var licError='';
//var licLineaError='';

var licControlErrores='';
//var LineaError='';

var licProductos	= new Array();
//15may17	var	licNumProductosEnviados;


//	2ene17	recuperamos los datos de ofertas de un proveedor
function prepararEnvio(nombreFichero, licRequisicao, licTituloPdc, licDataVencimento, licHoraVencimento, licMoeda, licObservacao, licUrgencia)
{
	var d= new Date();
	
	var datosFichero='Titulo_Pdc:'+licTituloPdc+'|'
				+'Data_Vencimento:'+licDataVencimento+'|'
				+'Hora_Vencimento:'+licHoraVencimento+'|'
				+'Moeda:'+licMoeda+'|'
				+'Observacao:'+licObservacao+'|'
				+'Urgencia:'+licUrgencia;

	//	Inicializamos las variables globales
	licIDFichero='';
	licIDLicitacion='';
	licIDSeleccion='';

	licStatus='OK';

	licError='';
	//licLineaError='';


	
	jQuery.ajax({
		cache:	false,
		async: false,
		url:	'http://www.newco.dev.br/Gestion/AdminTecnica/PrepararEnvioFichero.xsql',
		type:	"GET",
		data:	"NOMBRE="+nombreFichero+'&CODIGOCLIENTE='+licRequisicao+"&DATOSFICHERO="+datosFichero+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			licError='ERROR_CONECTANDO';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			//	Envio correcto de datos

			//solodebug
			//solodebug	console.log('prepararEnvioFichero: '+objeto);
			//solodebug	licIDFichero=1;
			
			console.log('prepararEnvioFichero licIDFichero:'+data.PrepararEnvio.IDFichero);
			
			licIDFichero=data.PrepararEnvio.IDFichero;
		}
	});
}

/*
//	10feb17 Separamos la creación de la licitación de la preparación del envío
function crearLicitacion(IDFichero, nombreFichero, licRequisicao, licTituloPdc, licDataVencimento, licHoraVencimento, licMoeda, licObservacao, licUrgencia, licIDSeleccion)
{
	var d= new Date();
	
	var datosFichero='Requisicao:'+licRequisicao+'|'
				+'Titulo_Pdc:'+licTituloPdc+'|'
				+'Data_Vencimento:'+licDataVencimento+'|'
				+'Hora_Vencimento:'+licHoraVencimento+'|'
				+'Moeda:'+licMoeda+'|'
				+'Observacao:'+licObservacao+'|'
				+'Urgencia:'+licUrgencia;
	
	jQuery.ajax({
		cache:	false,
		async: false,
		url:	'http://www.newco.dev.br/Gestion/AdminTecnica/CrearLicitacion.xsql',
		type:	"GET",
		data:	"NOMBRE="+nombreFichero+"&INTF_ID="+IDFichero+"&IDSELECCION="+licIDSeleccion+"&DATOSFICHERO="+datosFichero+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			licError='ERROR_CONECTANDO';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			//	Envio correcto de datos

			//solodebug
			//solodebug	console.log('prepararEnvioFichero: '+objeto);
			//solodebug	licIDFichero=1;
			
			console.log('crearLicitacion licIDLicitacion:'+data.Licitacion.IDLicitacion);
			
			licIDLicitacion=data.Licitacion.IDLicitacion;
		}
	});
}
*/

//	31dic16	recuperamos los datos de ofertas de un proveedor
/*
function nuevoProducto(numLineaInicio, RefCliente, Descripcion, Cantidad, TipoIVA)
{
	var d		= new Date();
	
	var texto	='Codigo:'+RefCliente+' Descripcion:'+Descripcion+' Cantidad:'+Cantidad;
		
	
	//solodebug	alert(" nuevoProductoINTF_ID="+licIDFichero+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));
		
	jQuery.ajax({
		cache:	false,
		async: false,
		url:	'http://www.newco.dev.br/Gestion/AdminTecnica/EnviarProducto.xsql',
		type:	"GET",
		data:	"INTF_ID="+licIDFichero+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA
					+"&NOMBREPRODUCTO="+encodeURIComponent(Descripcion)
					+"&TEXTO="+encodeURIComponent(texto)+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			licError='ERROR_ENVIANDO';
			console.log('enviarLineaFichero ERROR ENVIANDO: ('+RefCliente+') '+Descripcion);
			//licLineaError=numLineaInicio;
			
			return 'ERROR';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			
			//
			//	Control de errores en la funcion que llama a esta
			//
						
			licIDSeleccion=	data.Producto.IDSeleccion;

			//	Envio correcto de datos
			if (data.Producto.IDProductoLic!=-1)
			{
				console.log('enviarLineaFichero: IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+RefCliente+') '+Descripcion);
			}
			else
			{
				console.log('enviarLineaFichero ERROR ENVIANDO: ('+RefCliente+') '+Descripcion);
				licError='ERROR_ENVIANDO';
				return 'ERROR';
			}

			//solodebug	jQuery('#infoProgreso').html(texto);
			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			return data.Producto.IDProductoLic;
		}
	});
	
}
*/
//	Enviamos todos los productos al servidor
function EnviarTodosProductos(licNumProductosEnviados)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosProductos INTF_ID="+licIDFichero+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

	//	Entrada en el proceso
	
	//solodebug
	console.log('enviarLineaFichero: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+licProductos.length);

	if (licNumProductosEnviados>=licProductos.length)
	{

		if (licControlErrores==0)
		{
			//solodebug	console.log('enviarLineaFichero: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+licProductos.length + ' -> cerrarFichero sin errores');
			
			cerrarFichero(licNumProductosEnviados, 'OK');
			jQuery('#infoProgreso').html(str_LicitacionPreparada);
			jQuery('#infoProgreso').show();
			jQuery('#infoErrores').hide();
			location.reload(true);
			return 'OK';
		}
		else
		{
			//solodebug	
			console.log('enviarLineaFichero: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+licProductos.length + ' -> cerrarFichero CON ERROR');
			
			cerrarFichero(licNumProductosEnviados, 'ERROR');
			jQuery('#infoProgreso').hide();
			jQuery('#infoErrores').html(licControlErrores);
			jQuery('#infoErrores').show();
			return 'ERROR';
		}
	}
	//solodebug
	//else
	//{
	//	console.log('enviarLineaFichero: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+licProductos.length+ ' => enviando');
	//}

	var texto	='['+licProductos[licNumProductosEnviados].Codigo+'] '+licProductos[licNumProductosEnviados].Descripcion+': '+licProductos[licNumProductosEnviados].Cantidad;
	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	'http://www.newco.dev.br/Gestion/AdminTecnica/EnviarProducto.xsql',
		type:	"GET",
		data:	"INTF_ID="+licIDFichero+"&NUMLINEA="+licNumProductosEnviados+"&REFCLIENTE="+licProductos[licNumProductosEnviados].Codigo+"&CANTIDAD="+licProductos[licNumProductosEnviados].Cantidad+"&TIPOIVA="+"0"
					+"&NOMBREPRODUCTO="+encodeURIComponent(licProductos[licNumProductosEnviados].Descripcion)
					+"&ENTREGAS="+encodeURIComponent(licProductos[licNumProductosEnviados].Entregas)
					+"&CAMPOS_EXTRA="+encodeURIComponent(licProductos[licNumProductosEnviados].CamposExtra)
					+"&TEXTO="+encodeURIComponent(texto)+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			licError='ERROR_ENVIANDO';
			//licLineaError=numLineaInicio;
			
			licControlErrores+=licControlErrores+str_NoPodidoIncluirProducto+': ('+licProductos[licNumProductosEnviados].Codigo+') '+licProductos[licNumProductosEnviados].Descripcion+'<br/>';
			console.log('enviarLineaFichero: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+licProductos.length+ ' => ERROR enviando:'+quepaso);
			return 'ERROR';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			
			//
			//	Control de errores en la funcion que llama a esta
			//
						
			licIDSeleccion=	data.Producto.IDSeleccion;
			licProductos[licNumProductosEnviados].IDProductoLic=data.Producto.IDProductoLic;

			//	Procesar error
			/*if (data.Producto.IDProductoLic==-1)
			{
				console.log('enviarLineaFichero ERROR ENVIANDO: ('+RefCliente+') '+Descripcion);
				licError='ERROR_ENVIANDO';
				licControlErrores+=licControlErrores+str_NoPodidoIncluirProducto+': ('+licProductos[licNumProductosEnviados].Codigo+') '+licProductos[licNumProductosEnviados].Descripcion+'<br/>';
				licNumProductosEnviados=licNumProductosEnviados+1;
				EnviarTodosProductos(licNumProductosEnviados);					//	intentamos seguir enviando el resto
				return;
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+licProductos[licNumProductosEnviados].Codigo+') '+licProductos[licNumProductosEnviados].Descripcion);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumProductosEnviados=licNumProductosEnviados+1;
				EnviarTodosProductos(licNumProductosEnviados);		
				return;
			}*/

			console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+licProductos[licNumProductosEnviados].Codigo+') '+licProductos[licNumProductosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			licNumProductosEnviados=licNumProductosEnviados+1;
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
		data:	"IDFICHERO="+licIDFichero+"&NUMLINEAS="+numLineas+"&ESTADO="+estado+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			licError='ERROR_CONECTANDO';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			//	Envio correcto de datos

			//solodebug
			//solodebug	
			console.log('cerrarFichero: '+objeto);
			//solodebug	licIDFichero=1;
			
			console.log('cerrarFichero licIDFichero:'+data.Licitacion.IDLicitacion);
			
			//licIDLicitacion=data.Licitacion.IDLicitacion;
			//licIDFichero
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
	var licRequisicao, licTituloPdc, licDataVencimento, licHoraVencimento, licMoeda, licObservacao, licUrgencia, licAvisosCarga='', licControlErrores=''; 

	//	Variables de uso interno
	var count=0;
	var textoSalida='';

	jQuery('#infoProgreso').html('Inicio: preparando licitación a partir de XML estándar Brasil.');
	//$('#infoProgreso').redraw();


	//	26may17 Pasamos a utilizar la librería ObjTree.js		
	try
	{
		var xotree = new XML.ObjTree();			 
		var tree   = xotree.parseXML(fileContent);

		console.log('Leyendo cabecera');

		//	recuperamos datos generales de la licitacion
		licRequisicao=tree.Pedido.Cabecalho.Requisicao;
		licTituloPdc=tree.Pedido.Cabecalho.Titulo_Pdc;
		licDataVencimento=tree.Pedido.Cabecalho.Data_Vencimento;
		licHoraVencimento=tree.Pedido.Cabecalho.Hora_Vencimento;
		licMoeda=tree.Pedido.Cabecalho.Moeda;
		licObservacao=tree.Pedido.Cabecalho.Observacao;

		//	Campos extra a nivel de licitacion
		//	licUrgencia=tree.Pedido.Cabecalho.Campo_Extra.Nome;

		textoSalida='Requisicao:'+licRequisicao+'<br/>'
				+' Titulo_Pdc:'+licTituloPdc+'<br/>'
				+' Data_Vencimento:'+licDataVencimento+'<br/>'
				+' Hora_Vencimento:'+licHoraVencimento+'<br/>'
				+' Moeda:'+licMoeda+'<br/>'
				+' Observacao:'+licObservacao+'<br/>'
				+' Urgencia:'+licUrgencia+'<br/>'+'<br/>';

		console.log('Cabecera:'+textoSalida);

		textoSalida+='<br/>';


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
							/*	solodebug
							console.log('Procesado. Item['+i+']:'+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Codigo_Produto
									+': '+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Descricao_Produto
									+' ( Entrega: '+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega[j].Data
									+','+ tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega[j].Quantidade+')'
									);*/

							//var entregas= [];
							//entregas['Fecha']=tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega[j].Data;
							//entregas['Cantidad']=tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega[j].Quantidade;

							//items['Entregas'].push(entregas);

							items['Entregas']+=tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega[j].Data+'|'+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega[j].Quantidade+'#';

						}

					}
					else
					{
						/*	solodebug
						console.log('Procesado. Item['+i+']:'+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Codigo_Produto
								+': '+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Descricao_Produto
								+' ( Entrega: '+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega.Data
								+','+ tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega.Quantidade+')'
								);*/

						//var entregas= [];
						//entregas['Fecha']=tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega.Data;
						//entregas['Cantidad']=tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Programacao_Entrega.Quantidade;
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
							/*	solodebug
							console.log('Procesado. JSON.Item['+i+']:'+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Codigo_Produto
									+': '+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Descricao_Produto
									+' ( Entrega: '+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra[j].Nome
									+','+ tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra[j].Valor+')'
									);*/

							//var camposExtra= [];
							//camposExtra['Fecha']=tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra[j].Nome;
							//camposExtra['Cantidad']=tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra[j].Valor;

							//items['CamposExtra'].push(camposExtra);

							items['CamposExtra']+=tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra[j].Nome+'|'+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra[j].Valor+'#';
						}

					}
					else
					{
						/*	solodebug
						console.log('Procesado. JSON.Item['+i+']:'+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Codigo_Produto
								+': '+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Descricao_Produto
								+' ( Entrega: '+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra.Nome
								+','+ tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra.Valor+')'
								);*/

						//var camposExtra= [];
						//camposExtra['Fecha']=tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra.Nome;
						//camposExtra['Cantidad']=tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra.Valor;

						//items['CamposExtra'].push(camposExtra);
						items['CamposExtra']=tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra.Nome+'|'+tree.Pedido.Itens_Requisicao.Item_Requisicao[i].Campo_Extra.Valor;
					}
				}
				catch(err)
				{
					items['CamposExtra']='';
				}

 				licProductos.push(items);


				//solodebug
				console.log('Leyendo producto: ('+items['Codigo']+') '+items['Descripcion']+'. Cant:'+items['Cantidad']);

			}
			if (licAvisosCarga!='') alert(licAvisosCarga);

		}
		else
			textoSalida+='No se han encontrado productos.<br/>';

		textoSalida+='<br/>Num.productos:'+licProductos.length+'<br/>';
		
		//	solodebug
		//for  (i=0;i<licProductos.length;++i)
		//	textoSalida+='Linea '+i+' cod:'+licProductos[i].Codigo+' nombre:'+licProductos[i].Descripcion+' cant.:'+ licProductos[i].Cantidad
		//		+' entregas.:'+ licProductos[i].Entregas.length+' extra.:'+licProductos[i].CamposExtra.length+'<br/>';
	}
	catch(err)
	{
		licControlErrores='Formato XML incorrecto.';
	}


	//	Control de errores en el proceso
	if (licControlErrores=='')
	{
		document.getElementById("infoProgreso").innerHTML = str_CreandoLicitacion+': '+fileName;
		jQuery('#infoProgreso').show();
		
		//	solodebug	alert(str_CreandoLicitacion+': '+fileName);
		
		licControlErrores=EnviarLicitaciones(fileName, licIDLicitacion, licRequisicao, licTituloPdc, licDataVencimento, licHoraVencimento, licMoeda, licObservacao, licUrgencia, licProductos);
	}
	else
	{
		alert(licControlErrores);
	}
}


//	3mar17	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
function EnviarLicitaciones(fileName, licIDLicitacion, licRequisicao, licTituloPdc, licDataVencimento, licHoraVencimento, licMoeda, licObservacao, licUrgencia, licProductos)
{
	var licControlErrores='';

	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: '+fileName;
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvio(fileName, licRequisicao, licTituloPdc, licDataVencimento, licHoraVencimento, licMoeda, licObservacao, licUrgencia);

	//	Control de errores: -1 No se ha podido crear
	if (licIDFichero==-1)
	{
		licControlErrores+=str_ErrorDesconocidoCreandoFichero;
	}

	//	Control de errores: -2 fichero ya existe
	if (licIDFichero==-2)
	{
		licControlErrores+=str_FicheroYaEnviado;
	}


	//	Paso 2: Enviar productos
	if (licControlErrores=='')
	{
		
		//	Version recursiva
		//licNumProductosEnviados=0;
		EnviarTodosProductos(0);
		
	}
	else
	{
		document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: '+fileName+' ERROR:'+licControlErrores;
	}

	return licControlErrores;
}
