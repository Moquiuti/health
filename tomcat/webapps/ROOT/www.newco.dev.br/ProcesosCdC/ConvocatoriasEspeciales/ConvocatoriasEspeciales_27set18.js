//	JS para el envio de mantenimiento de productos via ajax a la plataforma medicalvm.com
//	ultima revision ET 11oct18 10:41

var Dominio='http://www.newco.dev.br';	//	facilita portabilidad

var	requiereIVA,
	requiereDatosAdicionalesCol;
	
var ficControlErrores='',
	ficID='';

var ficProductos	= new Array();

var nombreFic='';

var sepCampos='|';
	
//	Inicializa variables y textos según país y rol
function Inicializar()
{
	var titulo=ncRefProducto
				+sepCampos+ncProducto+sepCampos+ncMarca+sepCampos+ncFabricante+sepCampos+ncMedida
				+sepCampos+ncUdBasica+sepCampos+ncUdesLote+sepCampos
				+sepCampos+ncClasificacion+sepCampos+ncInvima+sepCampos+ncFechaInvima+sepCampos+ncClasRiesgo
				+sepCampos+ncPrecio+sepCampos+ncIVA+sepCampos+ncDescuento+sepCampos+ncBonificacion;
				
	jQuery("#formatoCarga").html(titulo);
				
	//	requiere IVA
	requiereIVA='S';

	//	campos especiales para Colombia
	requiereDatosAdicionalesCol='S';


}


//	Comprueba si hay convocatoria seleccionada para activar subida de ficheros
function selConvocatoria()
{
	var oForm = document.forms['frmProductos'];
	var IDConvocatoria = oForm.elements['FIDCONVOCATORIA'].value;
	
	if (IDConvocatoria!='' && IDConvocatoria!='-1')	oForm.elements['inputFile'].disabled=false;
	else oForm.elements['inputFile'].disabled=true;
}


//	Funcion principal para recuperar, comprobar y enviar los productos
function MantenCatalogosTXT()
{
	MantenCatProveedoresTXT();
}


//	Prepara la recuperación de fichero de disco y el envío según opción seleccionada
function EnviarFichero(files)
{
	//	Inicia la carga del fichero
	var file = files[0];

	var reader = new FileReader();

	reader.onload = function (e) {
		
		var Cont=true;
		var Stat=CompruebaConvocatoria();
		
		if (Stat!='') Cont=confirm(Stat);
		
		if (Cont)
		{
			console.log('Contenido fichero '+file.name);

			nombreFic=Piece(file.name,'.',0);			//11oct18
			ProcesarCatProveedoresTXT(e.target.result)
		}
	};

	reader.readAsText(file);
	
}


//	Comprueba si la convocatoria está informada, para avisar al usuario
function CompruebaConvocatoria()
{
	var IDConvocatoria = document.forms['frmProductos'].elements['FIDCONVOCATORIA'].value;
	var Status='';
	
	for (i=0;(i<Convocatorias.length)&&(Status=='');++i)
	{
		if ((Convocatorias[i].ID==IDConvocatoria)&&(Convocatorias[i].Procedimientos>0)) Status=strExistenProcedimientos.replace('[[PROCEDIMIENTOS]]',Convocatorias[i].Procedimientos);
		else if ((Convocatorias[i].ID==IDConvocatoria)&&(Convocatorias[i].Fichero!='')) Status=strExisteFichero.replace('[[FICHERO]]',Convocatorias[i].Fichero);
	}
	return Status;
}


//	Separamos la creación de la licitación de la preparación del envío
function cerrarFichero(numLineas, estado)
{
	var d= new Date();
	
	estado='OK';		//	11jun18	Si se ha llegado a enviar, aunque hayan algunos errores se marca como procesado

	//solodebug	
	console.log('cerrarFichero: numlineas:'+numLineas+ ' estado:'+estado+ ' llamando CerrarFichero');
		
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/ProcesosCdC/ConvocatoriasEspeciales/CerrarFichero.xsql',
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
			console.log('cerrarFicheroCatProv: '+objeto);
			//solodebug	ficID=1;
			
			//console.log('cerrarFicheroCatProv ficID:'+data.Licitacion.IDLicitacion);
			
			//ficIDLicitacion=data.Licitacion.IDLicitacion;
			//ficID
		}
	});
}



//
//	Mantenimiento del catálogo de proveedores
//


//	Funcion principal para recuperar, comprobar y enviar los productos
function MantenCatProveedoresTXT()
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';
	
	//solodebug	var Control='';

	var Referencias	= oForm.elements['TXT_PRODUCTOS'].value;
	Referencias	= Referencias.replace(/[\t]/g, sepCampos);			// 	Tabulador para separar columnas en excel -> '|'

	ProcesarCatProveedoresTXT(Referencias);
}



//	Funcion principal para recuperar, comprobar y enviar los productos
function ProcesarCatProveedoresTXT(CadenaCambios)
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';
	
	jQuery("#TXT_PRODUCTOS").hide();
	jQuery("#btnMantenProductos").hide();
	jQuery('#infoErrores').html('');
	
	var IDConvocatoria = oForm.elements['FIDCONVOCATORIA'].value;

	//solodebug	var Control='';

	CadenaCambios	= CadenaCambios.replace(/·/g, '');						//	Quitamos los caracteres que utilizaremos como separadores
	CadenaCambios	= CadenaCambios.replace(/(?:\r\n|\r|\n)/g, '·');
	
	var numRefs	= PieceCount(CadenaCambios, '·');
	
	//solodebug		alert('rev.15dic17 12:11\n\r'+CadenaCambios);
	
	ficProductos	= new Array();
	ficControlErrores ='';
	
	for (i=0;i<=numRefs;++i)
	{
		var Referencia,Nombre,Medida,UdBasica,UdesLote,Marca,Fabricante,Clasificacion,CodExpediente='',CodCUM='',CodInvima='',FechaVencInvima='',ClasRiesgo='',Precio,TipoIVA=0,Descuento=0,Bonificacion=0;
		var Producto= Piece(CadenaCambios, '·',i);

		//solodebug	alert('['+Producto+']');
		
		col=0;
			
		Referencia		= Piece(Producto, sepCampos, col);
		++col;
		Nombre			= Piece(Producto, sepCampos, col);
		++col;
		Medida			= Piece(Producto, sepCampos, col);
		++col;
		UdBasica		= Piece(Producto, sepCampos, col);
		++col;
		UdesLote		= Piece(Producto, sepCampos, col);
		++col;
		Marca			= Piece(Producto, sepCampos, col);
		++col;
		Fabricante		= Piece(Producto, sepCampos, col);
		++col;
		Clasificacion	= Piece(Producto, sepCampos, col);
		++col;
		CodInvima		= Piece(Producto, sepCampos, col);
		++col;
		FechaVencInvima	= Piece(Producto, sepCampos, col);
		++col;
		ClasRiesgo		= Piece(Producto, sepCampos, col);
		++col;
		Precio		= Piece(Producto, sepCampos, col);
		++col;
		TipoIVA		= Piece(Producto, sepCampos, col);
		++col;
		Descuento	= Piece(Producto, sepCampos, col);
		++col;
		Bonificacion= Piece(Producto, sepCampos, col);
		++col;

		if ((Referencia!='')&&(Referencia!='referencia producto')&&(Nombre!=''))		//	Eliminamos líneas vacias, Referencia!='Ref.Procedimiento' da un error extraño
		{

			//solodebug		
			console.log('MantenProductosTXT. Linea ('+i+'). Ref:'+Referencia+'. Prod:'+Nombre
				+'. UdBasica:'+UdBasica+'. UdesLote:'+UdesLote+'. Precio:'+Precio+'. TipoIVA:'+TipoIVA+'. CodInvima:'+CodInvima+'. FechaVencInvima:'+FechaVencInvima+'. ClasRiesgo:'+ClasRiesgo
				+'. Descuento:'+Descuento+'. Bonificacion:'+Bonificacion);

			var items		= [];

			items['Referencia']	= Referencia;
			items['Nombre'] = Nombre;
			items['Medida'] = Medida;
			items['UdBasica'] = UdBasica;
			items['UdesLote'] = UdesLote.replace(/\./g,"");
			items['Marca'] = Marca;
			items['Fabricante'] = Fabricante;
			items['Clasificacion'] = Clasificacion;

			items['CodExpediente'] = CodExpediente;
			items['CodCUM'] = CodCUM;
			items['CodInvima'] = CodInvima;
			items['FechaVencInvima'] = FechaVencInvima;
			items['ClasRiesgo'] = ClasRiesgo;

			items['Precio'] = Precio.replace(/\./g,"");		//	Eliminamos los puntos (separador de miles)
			items['TipoIVA'] = TipoIVA;

			items['Descuento'] = Descuento;
			items['Bonificacion'] = Bonificacion;
			
			items['IDProducto'] = '';							//	inicializaremos vía ajax

			
			//	Referencia
			if (Referencia=='')
			{
				licAvisosCarga += '('+(i+1)+') '+Nombre+': '+strReferenciaObligatoria +'<br/>';
			}
			
			//	Nombre
			if (Nombre=='')
			{
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strNombreObligatorio +'<br/>';
			}

			//	Marca
			//Marca opcional 4jun18	if (Marca=='')
			//Marca opcional 4jun18	{
			//Marca opcional 4jun18		licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strMarcaObligatoria +'<br/>';
			//Marca opcional 4jun18	}
			
			//	UdBasica
			if (UdBasica=='')
			{
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strUdBasica +'<br/>';
			}

			//	Udes/lote
			if (isNaN(parseFloat(items['UdesLote'])))
			{
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strUdesLoteNoNumerico +'['+items['UdesLote']+']<br/>';
			}

			//	Precio
			if (isNaN(parseFloat(items['Precio'])))
			{
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strPrecioNoNumerico  +'['+items['Precio']+']<br/>';
			}

			//	TipoIVA
			if ((requiereIVA=='S') && ((isNaN(parseFloat(items['TipoIVA'])))||(parseFloat(items['TipoIVA'])>99)) )
			{
				licAvisosCarga += '('+(i+1)+') '+Referencia+': AQUI '+strTipoIVAObligatorio +' ['+items['TipoIVA']+']<br/>';
			}

 			ficProductos.push(items);

			//solodebug
			console.log('Leyendo IDConvocatoria:'+IDConvocatoria+ ' Prod: ('+items['Referencia']+') '+items['Nombre']+'. Precio:'+items['Precio']);

		}
		else
		{
			//solodebug
			console.log('Descartando línea. Ref:'+Referencia+'. Prod:'+Nombre);
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
		
		ficControlErrores=EnviarFicheroCatProv(ficProductos);
	
	}
	else
	{
		alert(str_ErrSubirProductos);
	}
	
	jQuery("#btnMantenProductos").show();
	jQuery("#TXT_PRODUCTOS").show();
	
}




//	recuperamos los datos de ofertas de un proveedor
function prepararEnvioCatProv(nombreFichero)
{
	var d= new Date();
	

	//	Inicializamos las variables globales
	ficID='';
	ficError='';
	
	jQuery.ajax({
		cache:	false,
		async: false,
		url:	Dominio+'/ProcesosCdC/ConvocatoriasEspeciales/PrepararEnvioFichero.xsql',
		type:	"GET",
		data:	"NOMBRE="+nombreFichero+"&IDCONVOCATORIA="+document.forms['frmProductos'].elements['FIDCONVOCATORIA'].value+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			ficError='ERROR_CONECTANDO';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			//	Envio correcto de datos

			//solodebug
			//solodebug	console.log('prepararEnvioCatProvFichero: '+objeto);
			//solodebug	ficID=1;
			
			console.log('prepararEnvioCatProvFichero ficID:'+data.PrepararEnvio.IDFichero);
			
			ficID=data.PrepararEnvio.IDFichero;
		}
	});
}


//	Enviamos todos los productos al servidor
function EnviarTodosProductosCatProv(licNumProductosEnviados, ForzarNombre)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosProductosCatProv INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

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
			
			alert(str_FicheroProcesado+': '+nombreFic+' ('+strProcesados+':'+ficProductos.length+'/'+ficProductos.length+')');
			
			//	Mostramos la página con los productos
			MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProductos.xsql','convesp_buscadores',100,80,0,-10);
			
			ficID='';		//	Para poder reenviar la carga

			//
			//	RECUPERAR! location.reload(true);
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

			ficID='';		//	Para poder reenviar la carga

			return 'ERROR';
		}
	}
	//solodebug
	//else
	//{
	//	console.log('enviarLineaFichero: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length+ ' => enviando');
	//}

	var texto	=licNumProductosEnviados+'/'+ficProductos.length+': ['+ficProductos[licNumProductosEnviados].Referencia+'] '+ficProductos[licNumProductosEnviados].Nombre;

	var Otros=ficProductos[licNumProductosEnviados].CodExpediente+'|'
				+ficProductos[licNumProductosEnviados].CodCUM+'|'
				+ficProductos[licNumProductosEnviados].CodInvima+'|'
				+ficProductos[licNumProductosEnviados].FechaVencInvima+'|'
				+ficProductos[licNumProductosEnviados].ClasRiesgo;
	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/ProcesosCdC/ConvocatoriasEspeciales/MantenProductoAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumProductosEnviados
					+"&IDCONVOCATORIA="+document.forms['frmProductos'].elements['FIDCONVOCATORIA'].value
					+"&REFERENCIA="+encodeURIComponent(ficProductos[licNumProductosEnviados].Referencia)
					+"&NOMBRE="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Nombre))
					+"&MEDIDA="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Medida))
					+"&MARCA="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Marca))
					+"&FABRICANTE="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Fabricante))
					+"&CLASIFICACION="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Clasificacion))
					+"&UDBASICA="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].UdBasica))
					+"&UDESLOTE="+ficProductos[licNumProductosEnviados].UdesLote
					+"&PRECIO="+ficProductos[licNumProductosEnviados].Precio
					+"&TIPOIVA="+ficProductos[licNumProductosEnviados].TipoIVA
					+"&DESCUENTO="+ficProductos[licNumProductosEnviados].Descuento
					+"&BONIFICACION="+ficProductos[licNumProductosEnviados].Bonificacion
					+"&OTROS="+encodeURIComponent(ScapeHTMLString(Otros))		
					+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			ficError='ERROR_ENVIANDO';
			//licLineaError=numLineaInicio;
			
			ficControlErrores+=ficControlErrores+str_NoPodidoIncluirProducto;	//+': ('+ficProductos[licNumProductosEnviados].Referencia+') '+ficProductos[licNumProductosEnviados].Nombre+'<br/>';
			console.log('enviarLineaFichero [ERROR1]: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length+ ' => ERROR enviando:'+objeto+':'+quepaso+':'+otroobj);
			return 'ERROR';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			
			//
			//	Control de errores en la funcion que llama a esta
			//
						
			ficProductos[licNumProductosEnviados].IDProducto=data.EnviarLinea.idproducto;

			//	debug
			console.log('enviarLineaFichero: res:'||data.EnviarLinea.estado);
			
			//	Procesar error
			if (data.EnviarLinea.estado!='OK')
			{
				console.log('enviarLineaFichero [ERROR2]. ERROR ENVIANDO: ('+ficProductos[licNumProductosEnviados].Referencia+') '+ficProductos[licNumProductosEnviados].Nombre);
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+ficProductos[licNumProductosEnviados].Referencia+') '+ficProductos[licNumProductosEnviados].Nombre+':'+data.EnviarLinea.estado+'<br/>';
				licNumProductosEnviados=licNumProductosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDLineaMO:'+data.EnviarLinea.idproducto+' -> ('+ficProductos[licNumProductosEnviados].Referencia+') '+ficProductos[licNumProductosEnviados].Nombre);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumProductosEnviados=licNumProductosEnviados+1;
			}

			//console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumProductosEnviados].Codigo+') '+ficProductos[licNumProductosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumProductosEnviados=licNumProductosEnviados+1;
			EnviarTodosProductosCatProv(licNumProductosEnviados, ForzarNombre);		

		}
	});
	
}


//	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
function EnviarFicheroCatProv(ficProductos)
{
	var ficControlErrores='';
	var d= new Date();


	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero.';
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvioCatProv(nombreFic+'_'+IDUsuario+'_'+d.getYear()+d.getMonth()+d.getDay()+'_'+d.getHours()+d.getMinutes()+d.getSeconds());

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
		var ForzarNombre='N';
		
		if (jQuery('#chkForzar').attr('checked')) ForzarNombre='S';
		
		console.log('EnviarFicheroCatProv. ForzarNombre:'+ForzarNombre);
		
		//	Version recursiva
		EnviarTodosProductosCatProv(0, ForzarNombre);
		
	}
	else
	{
		document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: ERROR:'+ficControlErrores;
	}

	return ficControlErrores;
}





