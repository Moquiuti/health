//	JS para el envio de nuevas licitaciones via ajax a la plataforma medicalvm.com
//	ultima revision ET 05may20 16:00 AltaLicitacionesAjax_050520.js

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
	posMarca=-1,
	posIDSolicitud=-1,			//	16oct19
	posCampoExtra1=-1,			//	16mar20 Campos extra usados en TOTUS
	posCampoExtra2=-1,
	posCampoExtra3=-1,
	posCampoExtra4=-1,
	posCampoExtra5=-1,
	posCampoExtra6=-1;

var ficCamposCabecera= new Array();
var LineasCabecera;

//	2abr19 Inicializa los campos de la página
function Inicio()
{
	console.log('Inicio. multiCentros:'+multiCentros);

	if (multiCentros==='S') chCentro();
	PreparaModelo();
}

//	18feb20	Antes en LecturaYEnvioLicitacion
//	Carga un fichero para procesarlo
function enviarFichero(files) 
{
	var file = files[0];

	var reader = new FileReader();

	reader.onload = function (e) {
		
		console.log('enviarFichero '+file.name+':'+e.target.result);
		ProcesarFicheroXMLEstandarBrasil(file.name, e.target.result)
	};

	//18feb20 reader.readAsText(file, 'UTF-8');
	reader.readAsBinaryString(file);
}


//	18feb20	Antes en LecturaYEnvioLicitacion
//	21jun17	Enviar pedido desde texto (copy&paste desde excel, por ejemplo)
function EnviarPedidoDesdeTexto()
{
	ProcesarCadenaTXT();
}



//	Prepara el modelo para cargas CSV
function PreparaModelo()
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
				
				//solodebug	console.log('Inicio. Nuevo Item('+i+'):'+items['Tipo']+','+items['Fila']+','+items['Columna']);

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
				case 'IDSOLICITUD':
					posIDSolicitud=i;
					break;
				//	Textos traducidos al portugués
				case 'NUMPEDIDO':
					posCodPed=i;
					break;
				case 'NUMCENTROFACTURA':
					posCodCenFac=i;
					break;
				case 'CODFORNECEDOR':
					posCodProv=i;
					break;
				case 'CODPRODUTO':
					posCodProd=i;
					break;
				case 'QUANTIDADE':
					posCant=i;
					break;
				case 'UNIDADEBASICA':
					posUdBasica=i;
					break;
				//case 'CODCENTROENTREGA':
				//	posCodCenEnt=i;
				//	break;
				//case 'CODLUGARENTREGA':
				//	posCodLugEnt=i;
				//	break;
				//case 'LINEA':
				//	posLinea=i;
				//	break;
				case 'PRODUTO':
					posDescripcion=i;
					break;
				//case 'MARCA':
				//	posMarca=i;
				//	break;
				case 'IDSOLICITACAO':
					posIDSolicitud=i;
					break;
				case 'CAMPOEXTRA1':
					posCampoExtra1=i;
					break;
				case 'CAMPOEXTRA2':
					posCampoExtra2=i;
					break;
				case 'CAMPOEXTRA3':
					posCampoExtra3=i;
					break;
				case 'CAMPOEXTRA4':
					posCampoExtra4=i;
					break;
				case 'CAMPOEXTRA5':
					posCampoExtra5=i;
					break;
				case 'CAMPOEXTRA6':
					posCampoExtra6=i;
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


	//debug('prepararEnvio. ficRequisicao:'+ficRequisicao+' ficTituloPdc:'+ficTituloPdc+' ficDataVencimento:'+ficDataVencimento+' ficObservacao:'+ficObservacao);
	
	var Observacao, Titulo;
	
	try
	{
		//	Se produce error al aplicar replace a cadena vacía, aplicamos doble protección
		if (ficObservacao=='')
			Observacao='';
		else
			Observacao=ScapeHTMLString(ficObservacao.replace(/\r\n/g, '<br/>'));
	}
	catch(e)
	{
		//debug('prepararEnvio ficObservacao:'+ficObservacao+' err:'+e);
		Observacao='';
	}
	
	try
	{
		//	Se produce error al aplicar replace a cadena vacía, aplicamos doble protección
		if (ficTituloPdc=='')
			Titulo='';
		else
			Titulo=ScapeHTMLString(ficTituloPdc);
	}
	catch(e)
	{
		//debug('prepararEnvio ficObservacao:'+ficObservacao+' err:'+e);
		Titulo='';
	}
	
	
	
	var datosFichero='Titulo_Pdc:::'+Titulo+'|'		//27ene20 Otro problema si el título no está informado		
				+'Data_Vencimento:::'+ficDataVencimento+'|'
				+'Hora_Vencimento:::'+ficHoraVencimento+'|'
				+'Moeda:::'+ficMoeda+'|'
				+'Observacao:::'+Observacao+'|'	
				+'Urgencia:::'+ficUrgencia;

	//debug('prepararEnvio. datosFichero:'+datosFichero);

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
		data:	"NOMBRE="+nombreFichero+'&CODIGOCLIENTE='+ficRequisicao+"&DATOSFICHERO="+encodeURIComponent(datosFichero)+"&_="+d.getTime(),
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
			
			alert(str_FicheroProcesado+': '+ficProductos.length+'/'+ficProductos.length);
			


			//reactivar 				location.reload(true);



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

	var texto	=(licNumProductosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumProductosEnviados].Codigo+'] '+ficProductos[licNumProductosEnviados].Descripcion+': '+ficProductos[licNumProductosEnviados].Cantidad;

	//	Reccomponemos los campos extra en caso de fichero de texto 
	if 	(ficProductos[licNumProductosEnviados].CamposExtra=='')
	{
		ficProductos[licNumProductosEnviados].CamposExtra='CampoExtra1|'+ficProductos[licNumProductosEnviados].CampoExtra1+'#CampoExtra2|'+ ficProductos[licNumProductosEnviados].CampoExtra2
					+'#CampoExtra3|'+ficProductos[licNumProductosEnviados].CampoExtra3+'#CampoExtra4|'+ficProductos[licNumProductosEnviados].CampoExtra4
					+'#CampoExtra5|'+ficProductos[licNumProductosEnviados].CampoExtra5+'#CampoExtra6|'+ficProductos[licNumProductosEnviados].CampoExtra6;
	}			
					
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	'http://www.newco.dev.br/Gestion/AdminTecnica/EnviarProducto.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID+"&NUMLINEA="+licNumProductosEnviados+"&REFCLIENTE="+ficProductos[licNumProductosEnviados].Codigo+"&CANTIDAD="+ficProductos[licNumProductosEnviados].Cantidad+"&TIPOIVA="+"0"
					+"&LUGARENTREGA="+ficProductos[licNumProductosEnviados].LugarEntrega
					+"&CENTROCOSTE="+ficProductos[licNumProductosEnviados].CentroCoste
					+"&NOMBREPRODUCTO="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Descripcion))		//	5may20 Codificamos en formato HTML el envío de la descripción
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
			//var data = eval("(" + objeto + ")");
			
			var data = JSON.parse(objeto);
			
			//
			//	Control de errores en la funcion que llama a esta
			//
						
			ficIDSeleccion=	data.Producto.IDSeleccion;
			ficProductos[licNumProductosEnviados].IDProductoLic=data.Producto.IDProductoLic;

			//	debug
			console.log('enviarLineaFichero: res:'||data.Producto.estado);
			
			//	Procesar error
			if ((data.Producto.estado=='ERROR')||(data.Producto.estado!='OK'))
			{
				console.log('enviarLineaFichero ERROR ENVIANDO: ('+ficProductos[licNumProductosEnviados].Codigo+') '+ficProductos[licNumProductosEnviados].Descripcion);
				ficError='ERROR_ENVIANDO';
				ficControlErrores+=(licNumProductosEnviados+1)+'/'+ficProductos.length+'.'+str_NoPodidoIncluirProducto+': ('+ficProductos[licNumProductosEnviados].Codigo+') '+ficProductos[licNumProductosEnviados].Descripcion+'<br/>';
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
	var ficRequisicao, ficTituloPdc, ficDataVencimento, ficHoraVencimento, ficMoeda, ficObservacao, ficUrgencia='N', licAvisosCarga='', ficControlErrores=''; 

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
			items['IDSolicitud'] = '';		//	


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
				items['IDSolicitud'] = '';	
				//	16mar20 TOTUS	
				items['CampoExtra1'] = '';
				items['CampoExtra2'] = '';
				items['CampoExtra3'] = '';
				items['CampoExtra4'] = '';
				items['CampoExtra5'] = '';
				items['CampoExtra6'] = '';


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
		ficControlErrores='Formato XML incorrecto. Error:'+err;
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
		jQuery('#infoErrores').hide();
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
		//solodebug	Control='Separador:'+str_SeparadorFicPedidos;
		var re = new RegExp(str_SeparadorFicPedidos, 'g');
		Referencias	= Referencias.replace(re, '|');
		Referencias	= Referencias.replace(/\t/g, '|');			//	También los tabuladores, por si hacen copy/paste desde excel	
	}
	else
	{
		//solodebug	Control='Sin modelo de separador';
		
		//Referencias	= Referencias.replace(/[\t:]/g, '|');	
		Referencias	= Referencias.replace(/\t/g, '|');	
		Referencias	= Referencias.replace(/:/g, '|');	
	}
	
	var numRefs	= PieceCount(Referencias, '·');
	
	//solodebug
	//solodebug	Control+='\n\r';
	//solodebug	for (var z=0;z<Referencias.length;++z)
	//solodebug	{
	//solodebug		Control+=Referencias.charCodeAt(z)+'.';
	//solodebug	}
	
	//solodebug		alert('rev.14jun19 09:48\n\r'+Referencias+'\n\rdebug:'+Control+'\n\rnumlineas:'+numRefs+' LineasCabecera:'+LineasCabecera);
	//solodebug	return
	
	ficControlErrores ='';
	
	//	8abr19	Faltaba inicializar el array de productos
	ficProductos	= new Array();


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

	
	var NifCentroGl='',CodPedGl='';
	for (i=0;i<=numRefs;++i)
	{
		var NifCentro='',Ref,Cantidad,LugarEntrega='',CentroCoste='',Descripcion='',Precio='',UdBasica='',CodCenEnt='',CodProv='',CodPed='',Linea='',Producto='',Marca='',IDSolicitud='',
			CampoExtra1='',CampoExtra2='',CampoExtra3='',CampoExtra4='',CampoExtra5='',CampoExtra6='';
		var Producto	= Piece(Referencias, '·',i);
		

		if (i<LineasCabecera)
		{
			//solodebug	
			console.log('ProcesarCadenaPedidoTXT. Procesando cabecera('+i+'):'+Producto) ;
			
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
			if (posCodPed>=0) CodPed= QuitaLimites(Piece(Producto, '|', posCodPed),'"');
			else CodPed= CodPedGl;
			
			if (posCodCenFac>=0) NifCentro= QuitaLimites(Piece(Producto, '|', posCodCenFac),'"');
			else NifCentro= NifCentroGl;
			
			if (posCodProv>=0) CodProv= QuitaLimites(Piece(Producto, '|', posCodProv),'"');
			if (posCodProd>=0) Ref= QuitaLimites(Piece(Producto, '|', posCodProd),'"');
			if (posCant>=0) Cantidad= QuitaLimites(Piece(Producto, '|', posCant),'"');
			if (posUdBasica>=0) UdBasica= QuitaLimites(Piece(Producto, '|', posUdBasica),'"');
			if (posCodCenEnt>=0) CodCenEnt= QuitaLimites(Piece(Producto, '|', posCodCenEnt),'"');
			if (posCodLugEnt>=0) LugarEntrega= QuitaLimites(Piece(Producto, '|', posCodLugEnt),'"');
			if (posCodCenCoste>=0) CentroCoste= QuitaLimites(Piece(Producto, '|', posCodCenCoste),'"');
			if (posDescripcion>=0) Descripcion= QuitaLimites(Piece(Producto, '|', posDescripcion),'"');
			if (posPrecio>=0) Precio= QuitaLimites(Piece(Producto, '|', posPrecio),'"');
			if (posLinea>=0) Linea= QuitaLimites(Piece(Producto, '|', posLinea),'"');
			if (posMarca>=0) Marca=QuitaLimites(Piece(Producto, '|', posMarca),'"');
			if (posIDSolicitud>=0) IDSolicitud= QuitaLimites(Piece(Producto, '|', posIDSolicitud),'"');			//	16oct19 
			if (posCampoExtra1>=0) CampoExtra1= QuitaLimites(Piece(Producto, '|', posCampoExtra1),'"');			//	16mar20 
			if (posCampoExtra2>=0) CampoExtra2= QuitaLimites(Piece(Producto, '|', posCampoExtra2),'"');			//	16mar20 
			if (posCampoExtra3>=0) CampoExtra3= QuitaLimites(Piece(Producto, '|', posCampoExtra3),'"');			//	16mar20 
			if (posCampoExtra4>=0) CampoExtra4= QuitaLimites(Piece(Producto, '|', posCampoExtra4),'"');			//	16mar20 
			if (posCampoExtra5>=0) CampoExtra5= QuitaLimites(Piece(Producto, '|', posCampoExtra5),'"');			//	16mar20 
			if (posCampoExtra6>=0) CampoExtra6= QuitaLimites(Piece(Producto, '|', posCampoExtra6),'"');			//	16mar20 


			//solodebug		
			console.log('ProcesarCadenaTXT. Oferta ('+i+'). NifCentro:'+NifCentro+' IDSolicitud:'+IDSolicitud+' CodPed:'+CodPed+'. Ref:'+Ref+'. Cant:'+Cantidad+'. Entr:'+LugarEntrega+'. CenCoste:'+CentroCoste
				+'. Desc:'+Descripcion+'. Precio:'+Precio+'. UdBasica:'+UdBasica+'. CodCenEnt:'+CodCenEnt+'. CodProv:'+CodProv
				+ '. CampoExtra1:'+CampoExtra1+ '. CampoExtra2:'+CampoExtra2+ '. CampoExtra3:'+CampoExtra1+ '. CampoExtra3:'+CampoExtra1+ '. CampoExtra4:'+CampoExtra4+ '. CampoExtra5:'+CampoExtra5+ '. CampoExtra6:'+CampoExtra6
				+'. Linea:'+Linea+'. Marca:'+Marca+'. RegCompleto:'+Producto);

			if ((IDSolicitud!='NR_COT_COMPRA')&&(Ref!='')&&(Cantidad!='0')) 	 //  15dic17 Eliminamos líneas sin ref, cantidad 0, o que empiecen por NR_COT_COMPRA
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
				items['Marca'] = Marca;
				items['IDSolicitud'] = IDSolicitud;
				items['CampoExtra1'] = CampoExtra1;
				items['CampoExtra2'] = CampoExtra2;
				items['CampoExtra3'] = CampoExtra3;
				items['CampoExtra4'] = CampoExtra4;
				items['CampoExtra5'] = CampoExtra5;
				items['CampoExtra6'] = CampoExtra6;
				items['IDProductoLic']	=0;		//	Pendiente de inicializar
				
				//	5abr20 Mensaje de error si no está informada la cantidad
				if((Cantidad==''))
				{
					ficControlErrores += items['Codigo']+': '+items['Descripcion']+'. '+str_CantidadNoInformada +'\n\r';
				}
				
				
				//	16oct19 Utiliza el primer identificador de solicitud informado como identificador de toda la solicitud actual
				if ((IDSolicitud!='') && (ficRequisicao==='')) ficRequisicao=IDSolicitud;
				

				//	1jun17 COmprobamos qeu la cantidad sea un número entero
				if (items['Cantidad'].indexOf(',')!=-1)
				{
					var CantidadOld=items['Cantidad'];
					//5may20	items['Cantidad']=String(parseInt(items['Cantidad'].replace(",","."))+1);
					items['Cantidad']=String(parseInt(items['Cantidad'].replace(",",".")));
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

	//	16oct19 Si está informado el pedido pero no el ID de solicitud, utilizaremos el pedido como ID de solicitud
	if ((CodPedGl!='') && (ficRequisicao=='')) ficRequisicao=CodPedGl;


	//solodebug		
	console.log('ProcesarCadenaTXT. Titulo Fichero:'+ficTituloPdc);

	//	var aviso=alrt_AvisoOfertasActualizadas.replace('[[MODIFICADOS]]',Modificados).replace('[[NO_ENCONTRADOS]]',NoEncontrados+(NoEncontrados==0?".":":"+RefNoEncontradas))
	//alert(aviso);

	//	Control de errores en el proceso
	if (ficProductos.length==0)
	{
		alert(str_FicheroVacio);
		jQuery("#EnviarPedidoDesdeTexto").show();
	}	
	else if (ficControlErrores=='')
	{
		if ((licAvisosCarga=='')||confirm(licAvisosCarga))
		{
			document.getElementById("infoProgreso").innerHTML = str_CreandoLicitacion+': '+fileName;
			jQuery('#infoProgreso').show();

			//	solodebug	alert(str_CreandoLicitacion+': '+fileName);

			ficControlErrores=EnviarFichero(fileName, ficIDLicitacion, ficRequisicao, ficTituloPdc, ficDataVencimento, ficHoraVencimento, ficMoeda, ficObservacao, ficUrgencia, ficProductos);
		}
	}
	else
	{
		alert(ficControlErrores);
		jQuery("#EnviarPedidoDesdeTexto").show();
	}

}


//	16oct19 Cambio en el desplegable de centro
function chCentro()
{
	var ID=jQuery('#IDCENTRO').val(),
		Pos=-1;
	
	for (i=0;(i<arrCentros.length)&&(Pos==-1);++i)
	{
		if (arrCentros[i].ID==ID)	Pos=i;
	}
	
	if (Pos==-1) 
	{
		console.log('chCentro. ID:'+ID+' no encontrado');
		return;	//	No debería nunca pasar por aquí, pero para pruebas es útil este control
	}
	
	//solodebug console.log('chCentro. ID:'+ID+' en posicion:'+Pos);
	
	//	Prepara las variables de entorno
	str_ModeloFicPedidos= arrCentros[Pos].Linea;
	str_SeparadorFicPedidos= arrCentros[Pos].Separador;
	str_CabeceraFicPedidos= arrCentros[Pos].Cabecera;

	PreparaModelo();
}




// 8ago16	Funcion que abre la OC en el formato que corresponda (desde admintecnica)
function MostrarOC(IDFichero){
	MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/AdminTecnica/ExportarFicheroOC.xsql?IDFICHERO='+IDFichero,'',100,100,0,0);
}


// 22ago16	Funcion que descarga la OC en el formato que correspondam creado a partir de DescargarExcel (desde admintecnica)
function DescargarOC(IDFichero){
	var d = new Date();

	//alert('Detectar version de IE');
	if (navigator.userAgent.indexOf('MSIE') != -1)
	{
 		var detectIEregexp = /MSIE (\d+\.\d+);/ 
	}
	else { 
 		var detectIEregexp = /Trident.*rv[ :]*(\d+\.\d+)/ 
	}
	if (detectIEregexp.test(navigator.userAgent)){ 
 		var ieversion=new Number(RegExp.$1)
	}
	
	jQuery.ajax({
		url: 'http://www.newco.dev.br/Gestion/AdminTecnica/DescargaOC.xsql',
		data: "IDFICHERO="+IDFichero+"&_="+d.getTime(),
	type: "GET",
	contentType: "application/xhtml+xml",
	error: function(objeto, quepaso, otroobj){
	  alert('error'+quepaso+' '+otroobj+''+objeto);
	},
	success: function(objeto){
	
		var data = eval("(" + objeto + ")");

		var urlfichero='http://www.newco.dev.br/Descargas/'+data.url;

		if(data.estado == 'ok')
		{

			// Check for the various File API support.
			if (window.File && window.FileReader && window.FileList && window.Blob) {
				
				jQuery.get(urlfichero, function(fileContent) {
					

					var pom = document.createElement('a');
					
					// PS 26ago16 cambiar extension txt por xml
    				//pom.setAttribute('href', 'data:application/xhtml+xml;charset=utf-8,' + encodeURIComponent(fileContent));			    				
    				var strdataurl = data.url;
    				
					//20mar20 
					strdataurl=strdataurl.replace(".xml.txt",".xml");
					
					pom.setAttribute('href', 'data:text/html;charset=utf-8,' + encodeURIComponent(fileContent));
					
    				pom.setAttribute('download', strdataurl);

					// descargar para IE 11 o superior
					if (ieversion>=11) {
    					var blobObject = new Blob([fileContent]);
    					window.navigator.msSaveBlob(blobObject, strdataurl);
    					blobObject = new Blob(fileContent);
    					window.alert(blobObject);
    					
						
						//23mar20 window.navigator.msSaveOrOpenBlob(blobObject, strdataurl);
						window.navigator.msSaveOrOpenBlob(blobObject, strdataurl.replace('.xml',''));
					}
					// descargar para IE 10 o inferior
					if (ieversion<=10) {
						alert('otros IE');
					}

    				if (document.createEvent) {
        				var event = document.createEvent('MouseEvents');
        				event.initEvent('click', true, true);
        				pom.dispatchEvent(event);
    				}
    				else {
        				pom.click();
    				}
					
				});

			} else {
				//	Alguna de las APIs necesarias para la descarga no está soportada, por lo que abrimos directamente la página
				//alert('MostrarPagPersonalizada: ');
				// Para IE < 11: muestra ventana con toolbar y menú PS 29ago16
				MostrarXML(urlfichero);
				//MostrarPagPersonalizada(urlfichero,'XML',100,100,0,0);
			}
		}
		else{
			alert('Se ha producido un error. No se puede descargar el fichero '+urlfichero+'.');
		}
	}
  });
}

// Muestra un fichero directamente (desde admintecnica)
function MostrarXML(urlfichero){

	var url=urlfichero;
	var ventana="toolbar=1,location=1,resizable=1,width=600,height=600,top=0,left=0";
	win=window.open(url,"",ventana);

}

//	14nov19 QUita la apertura y cierre de cadena
function QuitaLimites(Cadena, Car)
{
	var l=Cadena.length;
	if ((Cadena.substring(0,1)==Car) &&(Cadena.substring(l-1,l)==Car))
		Cadena=Cadena.substring(1,l-1)
		
	return Cadena;
}





