//	JS para el envio de nuevas licitaciones via ajax a la plataforma medicalvm.com
//	ultima revision ET 16mar17 08:32

//	CUIDADO! PARA PRUEBAS, SE UTILIZAN LAS LIBRERIAS DE ENVIO DE FICHEROS
//	EN LUGAR DE LAS LICITACIONES

var licIDFichero;
var licIDLicitacion;
var licIDSeleccion;

var licStatus='OK';

var licError='';
//var licLineaError='';

var licControlErrores='';
//var LineaError='';


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


//	31dic16	recuperamos los datos de ofertas de un proveedor
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
			console.log('enviarLineaFichero: IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+RefCliente+') '+Descripcion);

			//solodebug	jQuery('#infoProgreso').html(texto);
			
			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			return data.Producto.IDProductoLic;
		}
	});
	
}


//	10feb17 Separamos la creación de la licitación de la preparación del envío
function cerrarFichero(numLineas, estado)
{
	var d= new Date();
		
	jQuery.ajax({
		cache:	false,
		async: false,
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
			//solodebug	console.log('prepararEnvioFichero: '+objeto);
			//solodebug	licIDFichero=1;
			
			console.log('crearLicitacion licIDFichero:'+data.Licitacion.IDLicitacion);
			
			licIDLicitacion=data.Licitacion.IDLicitacion;
			
			licIDFichero
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
	var licRequisicao, licTituloPdc, licDataVencimento, licHoraVencimento, licMoeda, licObservacao, licUrgencia; 
	var licProductos	= new Array();

	//	Variables de uso interno
	var count=0;
	var textoSalida='';

	jQuery('#infoProgreso').html('Inicio: preparando licitación a partir de XML estándar Brasil.');
	//$('#infoProgreso').redraw();

	//http://www.w3schools.com/xml/xml_parser.asp		
	//parser = new DOMParser();

	if (window.DOMParser) {
		// code for modern browsers
		parser = new DOMParser();
		var xmlDoc = parser.parseFromString(fileContent,"text/xml");
	} else {
		// code for old IE browsers
		var xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
		xmlDoc.async = false;
		xmlDoc.loadXML(fileContent);
	}  

	//xmlDoc = parser.parseFromString(fileContent,"text/xml");


	//	recuperamos datos generales de la licitacion
	licRequisicao=obtenerValor(xmlDoc, "Requisicao",0);
	licTituloPdc=obtenerValor(xmlDoc, "Titulo_Pdc",0);
	licDataVencimento=obtenerValor(xmlDoc, "Data_Vencimento",0);
	licHoraVencimento=obtenerValor(xmlDoc, "Hora_Vencimento",0);
	licMoeda=obtenerValor(xmlDoc, "Moeda",0);
	licObservacao=obtenerValor(xmlDoc, "Observacao",0);
	licUrgencia=obtenerValorPorPath(xmlDoc, "Pedido/Cabecalho/Campo_Extra/Nome");

	textoSalida='Requisicao:'+licRequisicao+'<br/>'
			+' Titulo_Pdc:'+licTituloPdc+'<br/>'
			+' Data_Vencimento:'+licDataVencimento+'<br/>'
			+' Hora_Vencimento:'+licHoraVencimento+'<br/>'
			+' Moeda:'+licMoeda+'<br/>'
			+' Observacao:'+licObservacao+'<br/>'
			+' Urgencia:'+licUrgencia+'<br/>'+'<br/>';


	console.log('Leyendo cabecera:'+textoSalida);

	/*var xmlCampoExtra=obtenerNodo(xmlDoc, "Campo_Extra",0);

	console.log('xmlCampoExtra:'+xmlCampoExtra);

	if (xmlCampoExtra!='')
		licUrgencia=obtenerValor(xmlCampoExtra, "Nome",0);
	else
		licUrgencia='NO';

	textoSalida+=' licUrgencia:'+licUrgencia;*/

	textoSalida+='<br/>';

	//textoSalida+=' Descricao_Produto:'+obtenerValorPorPath(xmlDoc, "Pedido/Itens_Requisicao/Item_Requisicao/Descricao_Produto");
	//textoSalida+='<br/>';

	var nodoProductos=obtenerNodoPorPath(xmlDoc, "Pedido/Itens_Requisicao");

	if (nodoProductos!='')
	{
		/*	Codigo de prueba, utilizando el path completo
		for (i=0;i<nodoProductos.getElementsByTagName("Item_Requisicao").length;++i)
		{
   			//var nodoProducto = nodoProductos.getElementsByTagName("Item_Requisicao")[i];

			//textoSalida+='\n\r'+obtenerValorPorPath(nodoProducto, 'Descricao_Produto');

			//textoSalida+='||'+nodoProductos.getElementsByTagName("Item_Requisicao")[i].getElementsByTagName('Descricao_Produto')[0].nodeValue;

			textoSalida+=' Codigo_Produto:'+obtenerValorPorPath(xmlDoc, "Pedido/Itens_Requisicao/Item_Requisicao["+i+"]/Codigo_Produto");
			textoSalida+=' Descricao_Produto:'+obtenerValorPorPath(xmlDoc, "Pedido/Itens_Requisicao/Item_Requisicao["+i+"]/Descricao_Produto");
			textoSalida+=' Quantidade:'+obtenerValorPorPath(xmlDoc, "Pedido/Itens_Requisicao/Item_Requisicao["+i+"]/Quantidade");
			textoSalida+='<br/>';
		}

		textoSalida+='*************************************************<br/>';
	*/
		//	A partir del nod de productos, recuperamos los datos de cada nodo
		for (i=0;i<nodoProductos.getElementsByTagName("Item_Requisicao").length;++i)
		{
			var items		= [];
			items['Codigo']	= obtenerValorPorPath(nodoProductos, "Item_Requisicao["+i+"]/Codigo_Produto");
			items['Descripcion'] = obtenerValorPorPath(nodoProductos, "Item_Requisicao["+i+"]/Descricao_Produto");
			items['Cantidad'] = obtenerValorPorPath(nodoProductos, "Item_Requisicao["+i+"]/Quantidade");
			items['IDProductoLic']	=0;		//	Pendiente de inicializar
 			licProductos.push(items);




  			//var nodoProducto = nodoProductos.getElementsByTagName("Item_Requisicao")[i];

			//textoSalida+='\n\r'+obtenerValorPorPath(nodoProducto, 'Descricao_Produto');

			//textoSalida+='||'+nodoProductos.getElementsByTagName("Item_Requisicao")[i].getElementsByTagName('Descricao_Produto')[0].nodeValue;

			//textoSalida+=' Codigo_Produto:'+obtenerValorPorPath(nodoProductos, "Item_Requisicao["+i+"]/Codigo_Produto");
			//textoSalida+=' Descricao_Produto:'+obtenerValorPorPath(nodoProductos, "Item_Requisicao["+i+"]/Descricao_Produto");
			//textoSalida+=' Quantidade:'+obtenerValorPorPath(nodoProductos, "Item_Requisicao["+i+"]/Quantidade");
			//textoSalida+='<br/>';


			//solodebug
			console.log('Leyendo producto: ('+items['Codigo']+') '+items['Descripcion']+'. Cant:'+items['Cantidad']);

		}

	}
	else
		textoSalida+='No se ha encontrado nodo productos.<br/>';

	textoSalida+='<br/>Num.productos:'+licProductos.length+'<br/>';

	for  (i=0;i<licProductos.length;++i)
		textoSalida+='Linea '+i+' cod:'+licProductos[i].Codigo+' nombre:'+licProductos[i].Descripcion+' cant.:'+ licProductos[i].Cantidad+'<br/>';


	//	Control de errores en el proceso
	if (licControlErrores=='')
	{
		document.getElementById("infoProgreso").innerHTML = str_CreandoLicitacion+': '+fileName;
		jQuery('#infoProgreso').show();
		
		//	solodebug	
		alert(str_CreandoLicitacion+': '+fileName);
		
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
	//solodebug	jQuery('#infoProgreso').hide();
	//jQuery('#infoProgreso').show();
	//jQuery('#infoProgreso').html('<p>Creando Licitacion: '+fileName+'</p>');
	//solodebug	jQuery('#infoProgreso2').html('Creando Licitacion: '+fileName);
	//solodebug	jQuery('#infoProgreso').hide();
	
	document.getElementById("infoProgreso").innerHTML = 'Creando Licitacion: '+fileName;
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//	solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
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

	/*	Las licitaciones se crearán a medida que añadimos productos, este paso sobra. Además todavía no tenemos inicializado licIDSeleccion
	//	Si no han habido errores con el fichero, creamos la licitacion
	if (licControlErrores=='')
	{
		crearLicitacion(licIDFichero, fileName, licRequisicao, licTituloPdc, licDataVencimento, licHoraVencimento, licMoeda, licObservacao, licUrgencia, licIDSeleccion);

		//	Control de errores: -1 No se ha podido crear
		if (licIDLicitacion==-1)
		{
			licControlErrores+=str_ErrorDesconocidoCreandoLicitacion;
		}
	}
	*/

	//	Paso 2: Enviar productos
	if (licControlErrores=='')
	{
		for  (i=0;i<licProductos.length;++i)
		{
			jQuery('#infoProgreso').html('Linea '+i+' cod:'+licProductos[i].Codigo+' nombre:'+licProductos[i].Descripcion+' cant.:'+ licProductos[i].Cantidad);
			licProductos[i].IDProductoLic=nuevoProducto(i, licProductos[i].Codigo,licProductos[i].Descripcion,licProductos[i].Cantidad, 0);

			//	Control de errores a nivel de producto

			if (licProductos[i].IDProductoLic<=0)
			{	
				licControlErrores+=licControlErrores+str_NoPodidoIncluirProducto+': ('+licProductos[i].Codigo+') '+licProductos[i].Descripcion+'<br/>';
			}

		}
	}

	//	Paso 4: cerrar fichero. Si no han habido errores, recargar la página
	if (licControlErrores=='')
	{
		console.log("cerrarFichero con "+licProductos.length+" productos, estado: OK");

		cerrarFichero(licProductos.length, 'OK');

		jQuery('#infoProgreso').html(str_LicitacionPreparada);
		jQuery('#infoProgreso').show();
		jQuery('#infoErrores').hide();
		location.reload(true);
	}
	else
	{
		console.log("cerrarFichero con "+licProductos.length+" productos, estado: ERROR");

		cerrarFichero(licProductos.length, 'ERROR');

		jQuery('#infoProgreso').hide();
		jQuery('#infoErrores').html(licControlErrores);
		jQuery('#infoErrores').show();
	}
	
	return licControlErrores;
}
