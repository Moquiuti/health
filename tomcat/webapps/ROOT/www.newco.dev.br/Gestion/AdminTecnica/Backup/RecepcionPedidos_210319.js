//	JS para el envio de nuevas licitaciones via ajax a la plataforma medicalvm.com
//	ultima revision ET 21mar19 09:30

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


//	18mar19 Prepara la recuperación de fichero de disco y el envío según opción seleccionada
function EnviarFicheroPedido(files)
{
	//	Inicia la carga del fichero
	var file = files[0];

	var reader = new FileReader();

	reader.onload = function (e) {
		
		console.log('Contenido fichero '+file.name);
		ProcesarCadenaTXT(e.target.result)
	};

	reader.readAsText(file);
	
}

//	21jun17	Enviar pedido desde texto (copy&paste desde excel, por ejemplo)
function RecepcionPedidosDesdeTexto()
{
	var oForm = document.forms['SubirDocumentos'];
	var licAvisosCarga ='';

	ProcesarCadenaTXT(oForm.elements['TXT_PRODUCTOS'].value);
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
			//solodebug	
			console.log('enviarLineaFichero: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length + ' -> cerrarFichero sin errores');
			
			cerrarFichero(licNumProductosEnviados, 'OK');
			jQuery('#infoProgreso').html(str_FicheroProcesado);
			jQuery('#infoProgreso').show();
			jQuery('#infoErrores').hide();
			
			alert(str_FicheroProcesado+': '+ficProductos.length+'/'+ficProductos.length);

			//
			location.reload(true);
			//
			
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

	var texto	=licNumProductosEnviados+'/'+ficProductos.length+': ['+ficProductos[licNumProductosEnviados].CodPedido+'] '+ficProductos[licNumProductosEnviados].RefCliente+': '+ficProductos[licNumProductosEnviados].Cantidad;
	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	'http://www.newco.dev.br/Gestion/AdminTecnica/RecepcionProducto.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID+"&CODPEDIDO="+encodeURIComponent(ficProductos[licNumProductosEnviados].CodPedido)
					+"&NUMLINEA="+licNumProductosEnviados
					+"&REFCLIENTE="+encodeURIComponent(ficProductos[licNumProductosEnviados].RefCliente)
					+"&CANTIDAD="+ficProductos[licNumProductosEnviados].Cantidad
					+"&NOMBREPRODUCTO="+encodeURIComponent(ficProductos[licNumProductosEnviados].Descripcion)
					+"&FECHA="+encodeURIComponent(ficProductos[licNumProductosEnviados].Fecha)
					+"&TEXTO="+encodeURIComponent(texto)+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			ficError='ERROR_ENVIANDO';
			//licLineaError=numLineaInicio;
			
			ficControlErrores+=ficControlErrores+str_NoPodidoIncluirProducto+ficProductos[licNumProductosEnviados].CodPedido+': ('+ficProductos[licNumProductosEnviados].RefCliente+') '+'<br/>';	//+ficProductos[licNumProductosEnviados].Descripcion
			console.log('enviarLineaFichero [ERROR1]: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length+ ' => ERROR enviando:'+objeto+':'+quepaso+':'+otroobj);
			return 'ERROR';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			
			//
			//	Control de errores en la funcion que llama a esta
			//
						
			ficProductos[licNumProductosEnviados].IDLineaMO=data.EnviarLinea.idlinea;

			//	debug
			console.log('enviarLineaFichero: res:'||data.EnviarLinea.estado);
			
			//	Procesar error
			if (data.EnviarLinea.estado!='OK')
			{
				console.log('enviarLineaFichero [ERROR2]. ERROR ENVIANDO: '+ficProductos[licNumProductosEnviados].CodPedido+':('+ficProductos[licNumProductosEnviados].RefCliente+') '+ficProductos[licNumProductosEnviados].Descripcion);
				ficError='ERROR_ENVIANDO';
				ficControlErrores+=ficProductos[licNumProductosEnviados].CodPedido+': ('+ficProductos[licNumProductosEnviados].RefCliente+'):'+data.EnviarLinea.estado+'<br/>';
				licNumProductosEnviados=licNumProductosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDLineaMO:'+data.EnviarLinea.idlinea+' -> ('+ficProductos[licNumProductosEnviados].Codigo+') '+ficProductos[licNumProductosEnviados].Descripcion);

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
		url:	'http://www.newco.dev.br/Gestion/AdminTecnica/FinFicheroRecepcion.xsql',
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


//	3mar17	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
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



//	21jun17	Extraemos los datos desde un areatext
function ProcesarCadenaTXT(ListaProductos)
{
	var d= new Date();
	var Cambios=false, Modificados=0, NoEncontrados=0, RefNoEncontradas='', Control='';
	var oForm = document.forms['SubirDocumentos'];
	var licAvisosCarga ='';
	
	jQuery("#EnviarPedidoDesdeTexto").hide();

	//solodebug	var Control='';

	var Referencias	= ListaProductos.replace(/(?:\r\n|\r|\n)/g, '·');
	Referencias	= ListaProductos.replace(/[\t:]/g, ':').replace('|', ':');	// 	Separadores admitidos para separar referencia de cantidad
	
	var numRefs	= PieceCount(Referencias, '·');
	
	//solodebug		alert('rev.15dic17 12:11\n\r'+Referencias);
	
	ficProductos	= new Array();
	ficControlErrores ='';
	
	for (i=0;i<=numRefs;++i)
	{
		var RefCliente,Cantidad,Descripcion,Precio;
		var Producto= Piece(Referencias, '·',i);

		//solodebug	alert('['+Producto+']');

		CodPedido	= Piece(Producto, ':', 0);
		RefCliente	= Piece(Producto, ':', 1);
		Cantidad	= Piece(Producto, ':', 2);
		Fecha		= Piece(Producto, ':', 3);
		Descripcion	= Piece(Producto, ':', 4);

		//solodebug		
		console.log('ProcesarCadenaTXT. Linea ('+i+'). CodPedido:'+CodPedido+'. Ref:'+RefCliente+'. Cant:'+Cantidad+'. Desc:'+Descripcion);

		if ((RefCliente!='')&&(Cantidad!='0'))		//	Eliminamos líneas sin ref o cantidad
		{
			var items		= [];
			items['CodPedido']	= CodPedido;
			items['RefCliente']	= RefCliente;
			items['Cantidad'] = Cantidad.replace(".","");		//	Eliminamos los puntos (separador de miles)
			items['Fecha'] = Fecha;
			items['Descripcion'] = Descripcion;
			items['IDLineaMO'] = '';							//	inicializaremos vía ajax

			//	1jun17 COmprobamos que la cantidad sea un número entero
			if (items['Cantidad'].indexOf(',')!=-1)
			{
				var CantidadOld=items['Cantidad'];
				items['Cantidad']=String(parseInt(items['Cantidad'].replace(",","."))+1);
				licAvisosCarga += items['RefCliente']+': '+items['Descripcion']+'. '+str_CambioCantidad.replace('[[CANTIDADOLD]]',CantidadOld).replace('[[CANTIDADNEW]]',items['Cantidad']) +'\n\r';
			}

 			ficProductos.push(items);

			//solodebug
			console.log('Leyendo CodPedido:'+CodPedido+' > producto: ('+items['RefCliente']+') '+items['Descripcion']+'. Cant:'+items['Cantidad']);

		}
		else
		{
			//solodebug
			console.log('Descartando línea en blanco:'+Producto);
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

		jQuery('#infoErrores').html('');
		jQuery('#infoErrores').hide();
	
		//	solodebug	alert(str_CreandoLicitacion+': '+fileName);
		
		ficControlErrores=EnviarFichero(fileName, ficIDLicitacion, ficRequisicao, ficTituloPdc, ficDataVencimento, ficHoraVencimento, ficMoeda, ficObservacao, ficUrgencia, ficProductos);
	}
	else
	{
		alert(ficControlErrores);
	}

}











