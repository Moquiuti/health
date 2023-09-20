//	Nueva carga de REGULADOS, separada para simplificar mantenimiento
//	Ultima revision: 17oct22  CargaRegulados_171022.js

/*
Registros para pruebas
M0000096|S|27000|Comentarios|Acido Nítrico 66%/30 mL
M0000097|N|50.000,0|Coments2|Acido Tricloroacetico 85%/20 mL 
*/


//	Funcion principal para recuperar, comprobar y enviar los productos
function ActualizarReguladosTXT()
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';
	
	var IDCliente = oForm.elements['FIDEMPRESA'].value;

	//solodebug	var Control='';

	var Referencias	= oForm.elements['TXT_PRODUCTOS'].value;
	Referencias	= Referencias.replace(/[\t]/g, sepCampos);			// 	Tabulador para separar columnas en excel -> '|'

	ProcesarReguladosTXT(Referencias);
}



//	Funcion principal para recuperar, comprobar y enviar los productos
function ProcesarReguladosTXT(CadenaCambios)
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';
	
	jQuery("#TXT_PRODUCTOS").hide();
	jQuery("#btnMantenProductos").hide();
	jQuery('#infoErrores').html('');
	
	var IDCliente = oForm.elements['FIDEMPRESA'].value;

	//solodebug	var Control='';

	CadenaCambios	= CadenaCambios.replace(/·/g, '');						//	Quitamos los caracteres que utilizaremos como separadores
	CadenaCambios	= CadenaCambios.replace(/(?:\r\n|\r|\n)/g, '·');
	
	var numRefs	= PieceCount(CadenaCambios, '·');
	
	//solodebug		alert('rev.15dic17 12:11\n\r'+CadenaCambios);
	
	ficProductos	= new Array();
	ficControlErrores ='';
	
	for (i=0;i<=numRefs;++i)
	{
		var CodProveedor,RefCliente,RefProveedor,Orden;
		var Producto= Piece(CadenaCambios, '·',i);

		//solodebug	alert('['+Producto+']');
		
		col=0;

		RefCliente	= Piece(Producto, sepCampos, col);
		++col;
		Regulado= Piece(Producto, sepCampos, col);
		++col;
		PrecioMax= Piece(Producto, sepCampos, col);
		++col;
		Comentarios= Piece(Producto, sepCampos, col);
		++col;
		Nombre= Piece(Producto, sepCampos, col);

		//solodebug		
		console.log('ProcesarReguladosTXT. Linea ('+i+'). RefCliente:'+RefCliente+'. Regulado:'+Regulado+'. PrecioMax:'+PrecioMax+'. Comentarios:'+Comentarios);

		if ((RefCliente!='RefCliente')&&(RefCliente!='')&&(Regulado!=''))		//	Eliminamos líneas vacias
		{
			var items		= [];
			items['IDCliente']	= IDCliente;
			items['RefCliente']	= RefCliente;
			items['Regulado']	= Regulado;
			items['PrecioMax']	= PrecioMax;
			items['Comentarios'] = Comentarios;
			items['Nombre'] = Nombre;
			
			items['IDProdEstandar'] = '';							//	inicializaremos vía ajax


			//	Comprobar campos obligatorios
			//	Cod Proveedor
			if (RefCliente=='')
			{
				licAvisosCarga += '('+(i+1)+') '+RefCliente+': '+strReferenciaObligatoria +'<br/>';
			}
			
			//	Regulado
			if (Regulado=='')
			{
				licAvisosCarga += '('+(i+1)+') '+RefCliente+':'+strCampoObligatorio+':'+ncRegulado +'<br/>';
			}
			else if ((Regulado!='S')&&(Regulado!='N'))
			{
				licAvisosCarga += '('+(i+1)+') '+RefCliente+':'+strReguladoSoN +'<br/>';
			}
			
			//	PrecioMax
			if  (isNaN(desformateaDivisa(PrecioMax)))
			{
				licAvisosCarga += '('+(i+1)+') '+RefCliente+': '+strPrecioNoNumerico +'<br/>';
			}

 			ficProductos.push(items);

			//solodebug
			console.log('Leyendo IDCliente:'+IDCliente+' RefCliente:'+ RefCliente+ ' Regulado:'+Regulado+' PrecioMax:'+PrecioMax+' Comentarios:'+Comentarios+' Nombre:'+Nombre);

		}
		else
		{
			//solodebug
			console.log('Descartando línea en blanco:'+Producto);
		}


	}

	//solodebug	
	console.log('ProcesarCadenaTXT. :'+licAvisosCarga);

	if (licAvisosCarga!='')
	{
		jQuery("#TXT_PRODUCTOS").show();
		jQuery('#infoProgreso').hide();
		jQuery('#infoErrores').html(licAvisosCarga);
		jQuery('#infoErrores').show();
	}
	



	//	var aviso=alrt_AvisoOfertasActualizadas.replace('[[MODIFICADOS]]',Modificados).replace('[[NO_ENCONTRADOS]]',NoEncontrados+(NoEncontrados==0?".":":"+RefNoEncontradas))
	//alert(aviso);

	//	Control de errores en el proceso
	if (licAvisosCarga=='')
	{
	
		//document.getElementById("infoProgreso").innerHTML = str_Iniciando;
		jQuery('#infoProgreso').show();
		
		//	solodebug	alert(str_CreandoLicitacion+': '+fileName);
		
		ficControlErrores=EnviarFicheroRegulados(ficProductos);
	
	}
	else
	{
		alert(str_ErrSubirProductos);
	}
	
	jQuery("#btnMantenProductos").show();
	jQuery("#TXT_PRODUCTOS").show();
	
}




//	2ene17	recuperamos los datos de ofertas de un proveedor
function prepararEnvioRegulados(nombreFichero)
{
	var d= new Date();
	

	//	Inicializamos las variables globales
	ficID='';
	ficError='';
	
	jQuery.ajax({
		cache:	false,
		async: false,
		url:	Dominio+'/Gestion/AdminTecnica/PrepararEnvioFichero.xsql',
		type:	"GET",
		data:	"NOMBRE="+nombreFichero+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			ficError='ERROR_CONECTANDO';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			//	Envio correcto de datos

			//solodebug
			//solodebug	console.log('prepararEnvioReguladosFichero: '+objeto);
			//solodebug	ficID=1;
			
			console.log('prepararEnvioReguladosFichero ficID:'+data.PrepararEnvio.IDFichero);
			
			ficID=data.PrepararEnvio.IDFichero;
		}
	});
}


//	Enviamos todos los productos al servidor
function EnviarTodosRegulados(licNumRegistrosEnviados)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosRegulados INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

	//	Entrada en el proceso
	
	//solodebug
	console.log('enviarLineaFichero: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length);

	if (licNumRegistrosEnviados>=ficProductos.length)
	{

		if (ficControlErrores==0)
		{
			//solodebug	
			console.log('enviarLineaFichero: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length + ' -> cerrarFichero sin errores');
			
			cerrarFichero(licNumRegistrosEnviados, 'OK');
			jQuery('#infoProgreso').html(str_FicheroProcesado);
			jQuery('#infoProgreso').show();
			jQuery('#infoErrores').hide();
			
			alert(str_FicheroProcesado+': '+ficProductos.length+'/'+ficProductos.length);
			
			ficID='';		//	Para poder reenviar la carga

			//
			//	RECUPERAR! location.reload(true);
			//
			
			return 'OK';
		}
		else
		{
			//solodebug	
			console.log('enviarLineaFichero: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length + ' -> cerrarFichero CON ERROR');
			cerrarFichero(licNumRegistrosEnviados, 'ERROR');
			jQuery('#infoProgreso').hide();
			jQuery('#infoErrores').html(ficControlErrores);
			jQuery('#infoErrores').show();

			ficID='';		//	Para poder reenviar la carga

			return 'ERROR';
		}
	}
	//solodebug
	//else
	//{
	//	console.log('enviarLineaFichero: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length+ ' => enviando');
	//}

	var texto	=(licNumRegistrosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumRegistrosEnviados].RefCliente+'] '+ficProductos[licNumRegistrosEnviados].Regulado+':'+ficProductos[licNumRegistrosEnviados].PrecioMax;
	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/ReguladosAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumRegistrosEnviados
					+"&IDCLIENTE="+ficProductos[licNumRegistrosEnviados].IDCliente
					+"&REFCLIENTE="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefCliente)
					+"&REGULADO="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].Regulado)
					+"&PRECIOMAX="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].PrecioMax)
					+"&COMENTARIOS="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].Comentarios)
					+"&PRODUCTO="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].Nombre)
					+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			ficError='ERROR_ENVIANDO';
			//licLineaError=numLineaInicio;
			
			ficControlErrores+=ficControlErrores+str_NoPodidoIncluirProducto;	//+': ('+ficProductos[licNumRegistrosEnviados].Referencia+') '+ficProductos[licNumRegistrosEnviados].Nombre+'<br/>';
			console.log('enviarLineaFichero [ERROR1]: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length+ ' => ERROR enviando:'+objeto+':'+quepaso+':'+otroobj);
			return 'ERROR';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			
			//
			//	Control de errores en la funcion que llama a esta
			//
						
			ficProductos[licNumRegistrosEnviados].IDProducto=data.EnviarLinea.idproducto;

			//	debug
			console.log('enviarLineaFichero: res:'||data.EnviarLinea.estado);
			
			//	Procesar error
			if (data.EnviarLinea.estado!='OK')
			{
				console.log('enviarLineaFichero [ERROR2]. ERROR ENVIANDO: ('+ficProductos[licNumRegistrosEnviados].RefCliente);
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+ficProductos[licNumRegistrosEnviados].RefCliente+'):'+data.EnviarLinea.estado+'<br/>';
				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDProducto:'+data.EnviarLinea.idproducto+' -> '+ficProductos[licNumRegistrosEnviados].RefCliente);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			}

			//console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumRegistrosEnviados].Codigo+') '+ficProductos[licNumRegistrosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			EnviarTodosRegulados(licNumRegistrosEnviados);		

		}
	});
}


//	3mar17	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
function EnviarFicheroRegulados(ficProductos)
{
	var ficControlErrores='';
	var d= new Date();


	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero.';
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvioRegulados('Regulados_'+IDUsuario+'_'+d.getYear()+d.getMonth()+d.getDay()+d.getHours()+d.getMinutes()+d.getSeconds());

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
		EnviarTodosRegulados(0);
		
	}
	else
	{
		document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: ERROR:'+ficControlErrores;
	}

	return ficControlErrores;
}

