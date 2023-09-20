//	JS para el envio de nuevas licitaciones via ajax a la plataforma medicalvm.com
//	ultima revision ET 4ene18 10:39

//	Contiene mucho c�digo de depuraci�n

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
					+"&NOMBREPRODUCTO="+encodeURIComponent(ficProductos[licNumProductosEnviados].Descripcion)
					+"&ENTREGAS="+encodeURIComponent(ficProductos[licNumProductosEnviados].Entregas)
					+"&CAMPOS_EXTRA="+encodeURIComponent(ficProductos[licNumProductosEnviados].CamposExtra)
					+"&NIF_CENTRO="+encodeURIComponent(ficProductos[licNumProductosEnviados].NifCentro)
					+"&PRECIO="+encodeURIComponent(ficProductos[licNumProductosEnviados].Precio)
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

//	10feb17 Separamos la creaci�n de la licitaci�n de la preparaci�n del env�o
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
//	Bloque principal del c�digo para procesar un fichero en formato "XML ESTANDAR BRASIL"
//
function ProcesarFicheroXMLEstandarBrasil(fileName, fileContent)
{
	// Cuando �ste evento se dispara, los datos est�n ya disponibles.
	//var output = document.getElementById("fileOutput");
	console.log('ProcesarFicheroXMLEstandarBrasil '+fileName+':'+fileContent);

	//	Datos generales de la licitacion
	var ficRequisicao, ficTituloPdc, ficDataVencimento, ficHoraVencimento, ficMoeda, ficObservacao, ficUrgencia, licAvisosCarga='', ficControlErrores=''; 

	//	Variables de uso interno
	var count=0;
	var textoSalida='';

	jQuery('#infoProgreso').html('Inicio: preparando licitaci�n a partir de XML est�ndar Brasil.');
	//$('#infoProgreso').redraw();


	//	26may17 Pasamos a utilizar la librer�a ObjTree.js		
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
		//	9oct17	En el caso de un �nico producto lo tratamos directamente
		//
		if (!Array.isArray(tree.Pedido.Itens_Requisicao.Item_Requisicao))
		{

			//solodebug	
			console.log('Recuperando un �nico producto del XML');
			
			var items		= [];
			items['Codigo']	= tree.Pedido.Itens_Requisicao.Item_Requisicao.Codigo_Produto;
			items['Descripcion'] = tree.Pedido.Itens_Requisicao.Item_Requisicao.Descricao_Produto;
			items['Cantidad'] = tree.Pedido.Itens_Requisicao.Item_Requisicao.Quantidade;
			items['IDProductoLic']	=0;		//	Pendiente de inicializar
			items['NifCentro']	= '';
			items['Precio']	= '';


			//	1jun17 COmprobamos qeu la cantidad sea un n�mero entero
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
		//	En el caso de m�ltiples productos recorremos el array
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


				//	1jun17 COmprobamos qeu la cantidad sea un n�mero entero
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


//	3mar17	Separamos la funci�n para enviar licitaciones, as� se podr� utilizar con diferentes formatos de ficheros de entrada
function EnviarFichero(fileName, ficIDLicitacion, ficRequisicao, ficTituloPdc, ficDataVencimento, ficHoraVencimento, ficMoeda, ficObservacao, ficUrgencia, ficProductos)
{
	var ficControlErrores='';

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



//	21jun17	Extraemos los daos desde un areatext
function ProcesarCadenaTXT()
{
	var d= new Date();
	var Cambios=false, Modificados=0, NoEncontrados=0, RefNoEncontradas='', Control='';
	var oForm = document.forms['SubirDocumentos'];
	var licAvisosCarga ='';
	
	jQuery("#EnviarPedidoDesdeTexto").hide();
	
	//solodebug	var Control='';

	var Referencias	= oForm.elements['TXT_PRODUCTOS'].value.replace(/(?:\r\n|\r|\n)/g, '|');
	Referencias	= Referencias.replace(/[\t:]/g, ':');	// 	Separadores admitidos para separar referencia de cantidad
	
	var numRefs	= PieceCount(Referencias, '|');
	
	//solodebug		alert('rev.15dic17 12:11\n\r'+Referencias);
	
	ficControlErrores ='';
	
	for (i=0;i<=numRefs;++i)
	{
		var Centro,Ref,Cantidad,Descripcion,Precio;
		var Producto	= Piece(Referencias, '|',i);

		//solodebug	alert('['+Producto+']');

		if (usMulticentros=='S')
		{
			Centro		= Piece(Producto, ':', 0);
			Ref			= Piece(Producto, ':', 1);
			Cantidad	= Piece(Producto, ':', 2);
			Descripcion	= Piece(Producto, ':', 3);
			Precio		= Piece(Producto, ':', 4);

			//solodebug		
			console.log('ProcesarCadenaTXT. Oferta ('+i+'). Centro:'+Centro+'. Ref:'+Ref+'. Cant:'+Cantidad+'. Desc:'+Descripcion+'. Precio:'+Precio);
			
			//	Centro no informado, la cantidad aparece en blanco
			if ((Cantidad=='')&&(Centro!=''))
				ficControlErrores+=str_CentroNoInformado.replace('[[REFERENCIA]]',Centro)+'\n\r';

		}
		else
		{
			Centro		= '';
			Ref			= Piece(Producto, ':', 0);
			Cantidad	= Piece(Producto, ':', 1);
			Descripcion	= Piece(Producto, ':', 2);
			Precio		= Piece(Producto, ':', 3);

			//solodebug		
			console.log('ProcesarCadenaTXT. Oferta ('+i+'). Ref:'+Ref+'. Cant:'+Cantidad+'. Desc:'+Descripcion+'. Precio:'+Precio);
		}

		if ((Ref!='')&&(Cantidad!='')&&(Cantidad!='0'))		//	15dic17	Eliminamos l�neas sin ref o cantidad
		{
			var items		= [];
			items['NifCentro']	= Centro;
			items['Codigo']	= Ref;
			items['Descripcion'] = Descripcion;
			items['Cantidad'] = Cantidad.replace(".","");		//	4ene18	Eliminamos los puntos (separador de miles)
			items['Precio'] = Precio;
			items['Entregas'] = '';
			items['CamposExtra'] = '';
			items['IDProductoLic']	=0;		//	Pendiente de inicializar

			//	1jun17 COmprobamos qeu la cantidad sea un n�mero entero
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
			console.log('Descartando l�nea en blanco:'+Producto);
		}


	}


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











