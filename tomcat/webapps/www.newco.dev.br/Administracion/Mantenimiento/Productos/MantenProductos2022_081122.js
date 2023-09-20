//	JS para el envio de mantenimiento de productos via ajax a la plataforma medicalvm.com
//	ultima revision ET 08nov22 09:00 MantenProductos2022_081122.js

var Dominio='http://www.newco.dev.br';											//	facilita portabilidad

var	requiereProveedor,
	requiereIVA,
	requiereDatosAdicionalesCol,
	requiereRegulado;
	
var ficControlErrores='',
	ficID='';

var ficProductos	= new Array();

var sepCampos='|';
	
//	Inicializa variables y textos según país y rol
function Inicializar()
{
	MostrarEstructuraDatos();
}


//	Muestra la estructura de datos necesaria para la carga
function MostrarEstructuraDatos()
{
	var titulo='';
	
	//	Inicializa variables globales
	requiereProveedor='N';
	requiereIVA='N';
	requiereDatosAdicionalesCol='N';
	requiereRegulado='N';

	var opcion = OpcionSeleccionada();

	jQuery("#trCliente").show();
	//jQuery("#trContrato").hide();
	jQuery("#Forzar").hide();
	
	if (opcion=='CLAS')
	{
		jQuery("#Forzar").show();
		titulo='['+ncRefCat+']'+sepCampos+ncRefCliCat+sepCampos+ncNombreCat
					+sepCampos+'['+ncRefFam+']'+sepCampos+ncRefCliFam+sepCampos+ncNombreFam
					+sepCampos+'['+ncRefSubFam+']'+sepCampos+ncRefCliSubFam+sepCampos+ncNombreSubFam
					+sepCampos+'['+ncRefGru+']'+sepCampos+ncRefCliGru+sepCampos+ncNombreGru
					+sepCampos+'[['+ncRefEstandar+']'+sepCampos+ncRefCliente+sepCampos+ncNombre+']';
	}
	else if (opcion=='PRODEST')
	{
		jQuery("#Forzar").show();
		titulo='['+ncRefEstandar+']'+sepCampos+ncRefCliente+sepCampos+ncNombre+sepCampos+ncMarcas+sepCampos+ncUdBasica;
		
		titulo+=sepCampos+ncPrecioRef;			//	Precio ref. ('' si no se dispone del dato)

		if (IDPais!=55)
		{
			requiereIVA='S';
			titulo+=sepCampos+ncIVA;			//	Brasil: no hay IVA. Resto, obligatorio ('' si no se dispone del dato)
		}

		if (IDPais==57)
		{
			requiereRegulado='S';
			titulo+=sepCampos+ncRegulado;		//	Colombia: regulado ('' si no se dispone del dato)
		}

		titulo+='['+sepCampos+ncOrden+sepCampos+ncCurvaABC;		//	orden y curva ABC (opcional)

		if (IDPais==55)
		{
			titulo+=sepCampos+ncRegistroMS+sepCampos+ncCaducidadMS+sepCampos+ncOncologico;			//	Brasil: no hay IVA. Resto, obligatorio ('' si no se dispone del dato)
		}
		titulo+=sepCampos+ncPrincipioActivo+sepCampos+ncGrupoDeStock+']';
	}
	else if (opcion=='CATPROV')
	{
		jQuery("#Forzar").show();
		if (Rol=='COMPRADOR')
		{
			requiereProveedor='S';
			titulo=ncNifProveedor+sepCampos;
		}

		titulo+=ncRefProveedor+sepCampos+ncNombre+sepCampos+ncMarca+sepCampos+ncUdBasica+sepCampos+ncUdesLote+'['+sepCampos+ncPrecio+']';

		if (IDPais!=55)
		{
			requiereIVA='S';
			titulo+=sepCampos+'['+ncIVA+']';
		}

		if (IDPais==57)
		{
			requiereDatosAdicionalesCol='S';
			titulo+=sepCampos+ncCodExpediente+sepCampos+ncCodIum+sepCampos+ncCodCum+sepCampos+ncInvima+sepCampos+ncFechaInvima+sepCampos+ncClasRiesgo;
		}
		
		titulo+='['+sepCampos+ncRefPack+sepCampos+ncCantidad+sepCampos+ncFechaInicioTarifa+sepCampos+ncFechaFinalTarifa+sepCampos+ncNombreDocumento+sepCampos+ncTipoNegociacion
		+sepCampos+ncAreaGeo+sepCampos+ncCodDivisa+sepCampos+ncCantBonif+sepCampos+ncCantGratis+']]';
	}
	else if (opcion=='ADJUD')
	{
		titulo=ncRefEstandar+sepCampos+ncNifProveedor+sepCampos+ncRefProveedor+'['+sepCampos+ncOrden+']';

	}
	else if (opcion=='HOMOL')
	{
	
		titulo=ncNifCentro+sepCampos+ncRefCentro+sepCampos+ncRefCliente+'['+sepCampos+ncNifProveedor+sepCampos+ncRefProveedor+sepCampos+ncAutorizado+'['+sepCampos+ncOrden+'['+sepCampos+ncUnidadBasica+'['+sepCampos+ncPrecioRef+']]]]';
	
	}
	else if (opcion=='PRECIOREF')
	{
	
		titulo=ncRefCliente+sepCampos+ncPrecioRef;
	
	}
	else if (opcion=='CAMBIOGRUPO')
	{
	
		titulo=ncRefCliente+sepCampos+ncRefGrupo+'['+sepCampos+ncRefEstandar+']';
	
	}
	else if (opcion=='IDENTIF')
	{
		titulo=ncNifProveedor+sepCampos+ncRefProveedor+'['+sepCampos+ncPrecio+'['+sepCampos+ncCantidad+'['+sepCampos+ncNombre+']]]';

	}
	else if (opcion=='PROVEED')
	{
		jQuery("#trCliente").hide();
		
		titulo=ncNifProveedor+sepCampos+ncProveedor+sepCampos+ncNombreCorto+sepCampos+ncDireccion+sepCampos+ncPoblacion+sepCampos+ncProvincia
					+sepCampos+ncBarrio+sepCampos+ncCodPostal+sepCampos+ncTelefono+sepCampos+ncPlazoEntrNormal+sepCampos+ncPlazoEnvio
					+sepCampos+ncUsuario+sepCampos+ncTelfUsuario+sepCampos+ncEmailUsuario;
		
	}
	/*else if (opcion=='MAESTRO')
	{
	
		jQuery("#trCliente").hide();
		titulo=ncNombreProdCli+sepCampos+ncNombreProdMaest+'['+sepCampos+ncRefFam+'['+sepCampos+ncNombreSubFam+'['+sepCampos+ncMarca+']]]';
	
	}*/
	/*else if (opcion=='CONTRATO')
	{
	
		jQuery("#trContrato").show();
		titulo='';
	
	}*/
	else if (opcion=='ASOCIARMAESTRO')
	{
	
		titulo=ncIDMaestro+sepCampos+ncRefMaestro+sepCampos+ncNombreProdMaest+sepCampos+'['+ncIDCliente+']'+sepCampos+ncRefCliente;
	
	}
	else if (opcion=='HISTPEDIDOS')
	{
		//	Numero OC	Proveedor	NIT	Comprador ID	Estado Orden	Codigo	Nombre SKU	Valor Unitario	Valor Unitario (Moneda)	DIVISA	Cantidad solicitada	Cantidad Remanente OC	Dinero Remanente (Moneda)	Fecha prevista entrega	Fecha OC
		titulo=ncNumeroPedido+sepCampos+ncLugarEntrega+sepCampos+ncCodCentroCoste+sepCampos+ncProveedor+sepCampos+ncNifProveedor+sepCampos+ncCodComprador+sepCampos+ncEstadoPedido+sepCampos+ncRefCliente
				+sepCampos+ncRefProveedor+sepCampos+ncNombre+sepCampos+ncUdBasica+sepCampos+ncUdesLote+sepCampos+ncIVA+sepCampos+ncPrecio
				+sepCampos+ncPrecio+'('+ncDivisa+')'+sepCampos+ncCodDivisa+sepCampos+ncCantidad+sepCampos
				+ncCantidadPendiente+sepCampos+ncImportePendiente+sepCampos+ncFechaPrevistaEntrega+sepCampos+ncFechaPedido;
	}
	else if (opcion=='TARIFAS')
	{
		titulo=ncNifProveedor+sepCampos+ncRefProveedor+sepCampos+ncPrecio+'['+sepCampos+ncNombre+'['+sepCampos+ncFechaFinalTarifa+'['+sepCampos+ncCantBonif+sepCampos+ncCantGratis+']]]';
	}
	else if (opcion=='TIPOIVA')
	{
		jQuery("#trCliente").hide();
		titulo=ncNifProveedor+sepCampos+ncRefProveedor+sepCampos+ncIVA+'['+sepCampos+ncNombre;
	}
	else if (opcion=='RESPEDIDOS')
	{
		//	Fecha RefCliente Producto Cantidad
		titulo=ncFechaPedido+sepCampos+ncRefCliente+sepCampos+ncNombre+sepCampos+ncCantidad;
	}
	else if (opcion=='CENTROSCOSTE')
	{
		//	Ref centro, Ref 
		titulo=ncNifCentro+sepCampos+ncCodCentroCoste+sepCampos+ncNombreCentroCoste+'['+sepCampos+ncPorDefecto+']';
	}
	else if (opcion=='REGULADOS')
	{
		//	Ref centro, Ref 
		titulo=ncRefCliente+sepCampos+ncRegulado+sepCampos+ncPrecioMax+sepCampos+ncComentarios+'['+sepCampos+ncNombre+']';
	}
	
		
	//solodebug	console.log('MostrarEstructuraDatos.'+opcion+':'+titulo);
	
	jQuery("#formatoCarga").html(titulo);
}



//	Funcion principal para recuperar, comprobar y enviar los productos
function MantenCatalogosTXT()
{
	var opcion = OpcionSeleccionada();
	
	//solodebug debug('MantenCatalogosTXT:'+opcion);
	
	if (opcion=='CLAS')
		MantenClasificacionTXT();
	else if (opcion=='PRODEST')
		MantenProdEstandarTXT();
	else if (opcion=='CATPROV')
		MantenCatProveedoresTXT();
	else if (opcion=='ADJUD')
		AdjudicacionTXT();
	else if (opcion=='HOMOL')
		HomologacionTXT();
	else if (opcion=='PRECIOREF')
		PreciosReferenciaTXT();
	else if (opcion=='IDENTIF')
		IdentificarProductosTXT();
	else if (opcion=='CAMBIOGRUPO')
		CambioGrupoTXT();
	else if (opcion=='PROVEED')
		ProveedoresTXT();
	else if (opcion=='MAESTRO')
		MaestroTXT();
	else if (opcion=='ASOCIARMAESTRO')
		AsociarAMaestroTXT();
	else if (opcion=='HISTPEDIDOS')
		HistoricoPedidosTXT();
	else if (opcion=='TARIFAS')
		ActualizarTarifasTXT();
	else if (opcion=='TIPOIVA')
		ActualizarTipoIvaTXT();
	else if (opcion=='RESPEDIDOS')
		ResumenPedidosTXT();
	else if (opcion=='CENTROSCOSTE')
		ActualizarCentrosCosteTXT();
	else if (opcion=='REGULADOS')
		ActualizarReguladosTXT();
	//else if (opcion=='CONTRATO')
	//	ContratoTXT();
	else
		alert('No implementado todavía, disculpe las molestias');
}


//	Devuelve la opcion seleccionada
function OpcionSeleccionada()
{
	return(document.forms['frmProductos'].elements['FIDOPCION'].value);
}



//	Prepara la recuperación de fichero de disco y el envío según opción seleccionada
function EnviarFichero(files)
{
	//	Inicia la carga del fichero
	var file = files[0];

	var reader = new FileReader();

	reader.onload = function (e) {
		
		console.log('Contenido fichero '+file.name);
		ProcesarFichero(file.name, e.target.result)
	};

	reader.readAsText(file);
	
}

//	Lee y procesa el fichero
function ProcesarFichero(fileName, fileContent)
{
	var opcion = OpcionSeleccionada();
	console.log('ProcesarFichero '+fileName+' Opcion:'+opcion+':\n\r'+fileContent);

	fileContent	= fileContent.replace(/[\t]/g, sepCampos);			// 	Tabulador para separar columnas en excel -> '|'

	if (opcion=='CLAS')
		ProcesarClasificacionTXT(fileContent);
	else if (opcion=='PRODEST')
		ProcesarProdEstandarTXT(fileContent);
	else if (opcion=='CATPROV')
		ProcesarCatProveedoresTXT(fileContent);
	else if (opcion=='ADJUD')
		ProcesarAdjudicacionTXT(fileContent);
	else if (opcion=='HOMOL')
		ProcesarHomologacionTXT(fileContent);
	else if (opcion=='PRECIOREF')
		ProcesarPreciosReferenciaTXT(fileContent);
	else if (opcion=='IDENTIF')
		ProcesarIdentificarProductosTXT(fileContent);
	else if (opcion=='CAMBIOGRUPO')
		ProcesarCambioGrupoTXT(fileContent);
	else if (opcion=='MAESTRO')
		ProcesarMaestroTXT(fileContent);
	else if (opcion=='ASOCIARMAESTRO')
		ProcesarAsociarAMaestroTXT(fileContent);
	else if (opcion=='PROVEED')
		ProcesarProveedoresTXT(fileContent);
	else if (opcion=='HISTPEDIDOS')
		ProcesarHistoricoPedidosTXT(fileContent);
	//else if (opcion=='CONTRATO')
	//	ProcesarContratoTXT(fileContent);
	else if (opcion=='TARIFAS')
		ProcesarActualizarTarifasTXT(fileContent);
	else if (opcion=='TIPOIVA')
		ProcesarActualizarTipoIvaTXT(fileContent);
	else if (opcion=='RESPEDIDOS')
		ProcesarResumenPedidosTXT(fileContent);
	else if (opcion=='CENTROSCOSTE')
		ProcesarResumenCentrosCosteTXT(fileContent);
	else if (opcion=='REGULADOS')
		ProcesarReguladosTXT(fileContent);
}

//	10feb17 Separamos la creación de la licitación de la preparación del envío
function cerrarFichero(numLineas, estado)
{
	var d= new Date();
	
	estado='OK';		//	11jun18	Si se ha llegado a enviar, aunque hayan algunos errores se marca como procesado

	//solodebug	
	console.log('cerrarFichero: numlineas:'+numLineas+ ' estado:'+estado+ ' llamando FinFicheroMantenCatalogos');
		
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/FinFicheroMantenCatalogos.xsql',
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
//	Mantenimiento de la clasificación en el catálogo privado
//


//	Funcion principal para recuperar, comprobar y enviar los productos
function MantenClasificacionTXT()
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';
	
	var IDCliente = oForm.elements['FIDEMPRESA'].value;

	//solodebug	var Control='';

	var Referencias	= oForm.elements['TXT_PRODUCTOS'].value;
	Referencias	= Referencias.replace(/[\t]/g, sepCampos);			// 	Tabulador para separar columnas en excel -> '|'

	ProcesarClasificacionTXT(Referencias);
}



//	Funcion principal para recuperar, comprobar y enviar los productos
function ProcesarClasificacionTXT(CadenaCambios)
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
		var RefCat, Cat, RefFam, Fam, RefSF, SF, RefGru, Gru, RefPro, RefCliPro, Pro;
		var Linea= Piece(CadenaCambios, '·',i);

		//solodebug		alert('Linea:['+Linea+']');
		
		col=0;
		RefCat	= Piece(Linea, sepCampos, col);
		++col;
		RefCliCat	= Piece(Linea, sepCampos, col);
		++col;
		Cat		= Piece(Linea, sepCampos, col);
		++col;
		RefFam	= Piece(Linea, sepCampos, col);
		++col;
		RefCliFam	= Piece(Linea, sepCampos, col);
		++col;
		Fam		= Piece(Linea, sepCampos, col);
		++col;
		RefSF	= Piece(Linea, sepCampos, col);
		++col;
		RefCliSF	= Piece(Linea, sepCampos, col);
		++col;
		SF		= Piece(Linea, sepCampos, col);
		++col;
		RefGru	= Piece(Linea, sepCampos, col);
		++col;
		RefCliGru	= Piece(Linea, sepCampos, col);
		++col;
		Gru		= Piece(Linea, sepCampos, col);
		++col;
		RefPro	= Piece(Linea, sepCampos, col);
		++col;
		RefCliPro	= Piece(Linea, sepCampos, col);
		++col;
		Pro		= Piece(Linea, sepCampos, col);

		//solodebug		
		console.log('ProcesarClasificacionTXT. Linea ('+i+')'+':'+Linea+'. RefCat:'+RefCat+'. Cat:'+Cat+'. RefFam:'+RefFam
					+'. Fam:'+Fam+'. RefSF:'+RefSF+'. SF:'+SF+'. RefGru:'+RefGru+'. Gru:'+Gru+ ' RefPro:'+RefPro+' RefCliPro:'+RefCliPro+' Pro:'+Pro);

		licAvisosCarga='';
		if (Linea!='')		//	Eliminamos líneas vacias
		{
			var items		= [];
			items['IDCliente']	= IDCliente;
			items['RefCat']	= RefCat;
			items['RefCliCat']	= RefCliCat;
			items['Cat']= Cat;
			items['RefFam']	= RefFam;
			items['RefCliFam']	= RefCliFam;
			items['Fam'] = Fam;
			items['RefSF'] = RefSF;
			items['RefCliSF'] = RefCliSF;
			items['SF'] = SF;
			items['RefGru'] = RefGru;
			items['RefCliGru'] = RefCliGru;
			items['Gru'] = Gru;
			items['RefPro'] = RefPro;
			items['RefCliPro'] = RefCliPro;
			items['Pro'] = Pro;
			items['IDLinea'] = '';							//	inicializaremos vía ajax

			//	Comprobar campos obligatorios, desde 9ene19 las referencias son opcionales
			
			//	Referencia
			//if (RefCat=='')
			//{
			//	licAvisosCarga += '('+(i+1)+') '+strRefCatObligatoria +'<br/>';
			//}
			
			//	Nombre
			if (Cat=='')
			{
				licAvisosCarga += '('+(i+1)+') '+Cat+': '+strCatObligatoria +'<br/>';
			}
			
			//	Referencia
			//if (RefFam=='')
			//{
			//	licAvisosCarga += '('+(i+1)+') '+RefCat+': '+strRefFamObligatoria +'<br/>';
			//}
			
			//	Nombre
			if (Fam=='')
			{
				licAvisosCarga += '('+(i+1)+') '+RefFam+': '+strFamObligatoria +'<br/>';
			}
			
			//	Referencia
			//if (RefSF=='')
			//{
			//	licAvisosCarga += '('+(i+1)+') '+RefFam+': '+strRefSFObligatoria +'<br/>';
			//}
			
			//	Nombre
			if (SF=='')
			{
				licAvisosCarga += '('+(i+1)+') '+RefSF+': '+strSFObligatoria +'<br/>';
			}
			
			//	Referencia
			//if (RefGru=='')
			//{
			//	licAvisosCarga += '('+(i+1)+') '+RefSF+': '+strRefGruObligatoria +'<br/>';
			//}
			
			//	Nombre
			if (Gru=='')
			{
				licAvisosCarga += '('+(i+1)+') '+RefGru+': '+strGruObligatorio +'<br/>';
			}
				
 			ficProductos.push(items);

			//solodebug
			console.log('ProcesarClasificacionTXT. Linea ('+i+'). RefCat:'+RefCat+'. Cat:'+Cat+'. RefFam:'+RefFam
					+'. Fam:'+Fam+'. RefSF:'+RefSF+'. SF:'+SF+'. RefGru:'+RefGru+'. Gru:'+Gru+ ' RefPro:'+RefPro+' RefCliPro:'+RefCliPro+' Pro:'+Pro+ ' Avisos:'+licAvisosCarga);
		}
		else
		{
			//solodebug
			console.log('Descartando línea en blanco:'+Linea);
		}


	}

	//solodebug	
	console.log('ProcesarClasificacionTXT. :'+licAvisosCarga);

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
		
		ficControlErrores=EnviarFicheroClasificacion(ficProductos);
	
	}
	else
	{
		alert(str_ErrSubirProductos);
	}
	
	jQuery("#btnMantenProductos").show();
	jQuery("#TXT_PRODUCTOS").show();
	
}




//	2ene17	recuperamos los datos de ofertas de un proveedor
function prepararEnvioClasificacion(nombreFichero)
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
			//solodebug	console.log('prepararEnvioProdEstandarFichero: '+objeto);
			//solodebug	ficID=1;
			
			console.log('prepararEnvioClasificacion ficID:'+data.PrepararEnvio.IDFichero);
			
			ficID=data.PrepararEnvio.IDFichero;
		}
	});
}


//	Enviamos todos los productos al servidor
function EnviarTodosClasificacion(licNumRegistrosEnviados, ForzarNombre)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosProductosProdEstandar INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

	//	Entrada en el proceso
	
	//solodebug
	console.log('EnviarTodosClasificacion: licNumRegistrosEnviados:'+licNumRegistrosEnviados+' ForzarNombre:'+ForzarNombre+ ' total:'+ficProductos.length);

	if (licNumRegistrosEnviados>=ficProductos.length)
	{

		if (ficControlErrores==0)
		{
			//solodebug	
			console.log('EnviarTodosClasificacion: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length + ' -> cerrarFichero sin errores');
			
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
			console.log('EnviarTodosClasificacion: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length + ' -> cerrarFichero CON ERROR');
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

	var texto	=(licNumRegistrosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumRegistrosEnviados].RefGru+'] '+ficProductos[licNumRegistrosEnviados].Gru;
		
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/MantenClasificacionAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumRegistrosEnviados
					+"&IDCLIENTE="+ficProductos[licNumRegistrosEnviados].IDCliente
					+"&REFCAT="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefCat)
					+"&REFCLICAT="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefCliCat)
					+"&CAT="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].Cat))
					+"&REFFAM="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefFam)
					+"&REFCLIFAM="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefCliFam)
					+"&FAM="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].Fam))
					+"&REFSF="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefSF)
					+"&REFCLISF="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefCliSF)
					+"&SF="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].SF))
					+"&REFGRU="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefGru)
					+"&REFCLIGRU="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefCliGru)
					+"&GRU="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].Gru))
					+"&REFPRO="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefPro)
					+"&REFCLIPRO="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefCliPro)
					+"&PRO="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].Pro))
					+"&FORZARNOMBRE="+ForzarNombre,
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			ficError='ERROR_ENVIANDO';
			//licLineaError=numLineaInicio;
			
			ficControlErrores+=ficControlErrores+str_NoPodidoIncluirProducto;	//+': ('+ficProductos[licNumRegistrosEnviados].RefEstandar+') '+ficProductos[licNumRegistrosEnviados].Nombre+'<br/>';
			console.log('enviarProdEstandar [ERROR1]: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length+ ' => ERROR enviando:'+objeto+':'+quepaso+':'+otroobj);
			return 'ERROR';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			
			//
			//	Control de errores en la funcion que llama a esta
			//
						
			ficProductos[licNumRegistrosEnviados].IDProducto=data.EnviarLinea.idproducto;

			//	debug
			console.log('enviarProdEstandar: res:'||data.EnviarLinea.estado);
			
			//	Procesar error
			if (data.EnviarLinea.estado!='OK')
			{
				console.log('EnviarTodosClasificacion [ERROR2]. ERROR ENVIANDO: ('+licNumRegistrosEnviados+') '+ficProductos[licNumRegistrosEnviados].Cat);
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+licNumRegistrosEnviados+') '+ficProductos[licNumRegistrosEnviados].Cat+':'+data.EnviarLinea.estado+'<br/>';
				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('EnviarTodosClasificacion: ENVIO CORRECTO. IDProdEstandar:'+data.EnviarLinea.idproducto+' -> ('+licNumRegistrosEnviados+') '+ficProductos[licNumRegistrosEnviados].Cat);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			}

			//console.log('enviarProdEstandar: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumRegistrosEnviados].RefCat+') '+ficProductos[licNumRegistrosEnviados].Cat);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			EnviarTodosClasificacion(licNumRegistrosEnviados, ForzarNombre);		

		}
	});
	
}


//	3mar17	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
function EnviarFicheroClasificacion(ficProductos)
{
	var ficControlErrores='';
	var d= new Date();


	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero.';
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvioClasificacion('MANTENPRODESTANDAR_'+IDUsuario+'_'+d.getYear()+d.getMonth()+d.getDay()+d.getHours()+d.getMinutes()+d.getSeconds());

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
		
		if (jQuery('#chkForzar').is(':checked')) ForzarNombre='S';				//	30jun22 antes:.attr('checked')
		
		console.log('EnviarFicheroClasificacion. ID checkbox:'+jQuery('#chkForzar').attr('id') +'> ForzarNombre:'+ForzarNombre);
	
		
		//	Version recursiva
		EnviarTodosClasificacion(0, ForzarNombre);
		
	}
	else
	{
		document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: ERROR:'+ficControlErrores;
	}

	return ficControlErrores;
}




//
//	Mantenimiento de los productos estándar en el catálogo privado
//


//	Funcion principal para recuperar, comprobar y enviar los productos
function MantenProdEstandarTXT()
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';
	
	var IDCliente = oForm.elements['FIDEMPRESA'].value;

	//solodebug	var Control='';

	var Referencias	= oForm.elements['TXT_PRODUCTOS'].value;
	Referencias	= Referencias.replace(/[\t]/g, sepCampos);			// 	Tabulador para separar columnas en excel -> '|'

	ProcesarProdEstandarTXT(Referencias);
}



//	Funcion principal para recuperar, comprobar y enviar los productos
function ProcesarProdEstandarTXT(CadenaCambios)
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
		var RefEstandar, RefCliente, Nombre, Marcas, PrecioRef, TipoIVA=0, Regulado='N', CurvaABC='', Orden='1', Registro='', FechaCadRegistro='', Oncologico='N', PrincipioActivo='', GrupoStock='';
		var Producto= Piece(CadenaCambios, '·',i);

		//solodebug		
		console.log('MantenProductosTXT. Linea ('+i+').Producto:'+Producto);
		
		col=0;
		RefEstandar	= Piece(Producto, sepCampos, col);
		++col;
		RefCliente	= Piece(Producto, sepCampos, col);
		++col;
		Nombre		= Piece(Producto, sepCampos, col);
		++col;
		Marcas		= Piece(Producto, sepCampos, col);
		++col;
		UdBasica	= Piece(Producto, sepCampos, col);
		++col;
		PrecioRef	= Piece(Producto, sepCampos, col);
		++col;
		
		if (requiereIVA=='S')
		{
			TipoIVA = Piece(Producto, sepCampos, col);
			++col;
		}
		
		if (requiereRegulado=='S')
		{
			Regulado = Piece(Producto, sepCampos, col);
			++col;
		}

		Orden	= Piece(Producto, sepCampos, col);
		++col;
		CurvaABC= Piece(Producto, sepCampos, col);
		++col;
		
		if  (IDPais==55)
		{
			Registro=Piece(Producto, sepCampos, col); 
			++col;
			FechaCadRegistro=Piece(Producto, sepCampos, col);
			++col;
			Oncologico=Piece(Producto, sepCampos, col);
			++col;
		}
		PrincipioActivo= Piece(Producto, sepCampos, col);
		++col;
		GrupoStock= Piece(Producto, sepCampos, col);
		++col;


		//solodebug		
		console.log('MantenProductosTXT. Linea ('+i+'). RefEstandar:'+RefEstandar+'. Prod:'+Nombre+'. Marcas:'+Marcas
			+'. UdBasica:'+UdBasica+'. PrecioRef:'+PrecioRef+'. TipoIVA:'+TipoIVA+'. Regulado:'+Regulado+'. CurvaABC:'+CurvaABC
			+'. Registro:'+Registro+'. FechaCadRegistro:'+FechaCadRegistro+'. Oncologico:'+Oncologico+'. PrincipioActivo:'+PrincipioActivo);

		if ((RefEstandar!='')||(Nombre!=''))		//	Eliminamos líneas vacias
		{
			var items		= [];
			items['IDCliente']	= IDCliente;
			items['RefEstandar']= RefEstandar;
			items['RefCliente']	= RefCliente;
			items['Nombre'] = Nombre;
			items['Marcas'] = Marcas;
			items['UdBasica'] = UdBasica;
			items['PrecioRef'] = PrecioRef.replace(/\./g,"");		//	Eliminamos los puntos (separador de miles)
			items['TipoIVA'] = TipoIVA;

			items['Regulado'] = Regulado;
			items['Orden'] = Orden;
			items['CurvaABC'] = CurvaABC;

			items['Registro'] = Registro;
			items['FechaCadRegistro'] = FechaCadRegistro;
			items['Oncologico'] = Oncologico;
			items['PrincipioActivo'] = PrincipioActivo;
			items['GrupoStock'] = GrupoStock;
			
			items['IDProducto'] = '';							//	inicializaremos vía ajax


			//	Comprobar campos obligatorios
			
			//	Referencia
			if ((RefEstandar=='')&&(RefCliente==''))
			{
					licAvisosCarga += '('+(i+1)+') '+RefEstandar+': '+strReferenciaObligatoria +'<br/>';
			}
			
			//	Nombre
			if (Nombre=='')
			{
				licAvisosCarga += '('+(i+1)+') '+RefEstandar+': '+strNombreObligatorio +'<br/>';
			}
			
			//	UdBasica
			if (UdBasica=='')
			{
				licAvisosCarga += '('+(i+1)+') '+RefEstandar+': '+strUdBasica +'<br/>';
			}

			//	Precio ref: comprobar formato solo si está informado
			//5jun18	if (!isNaN(items['PrecioRef'])&&(isNaN(parseFloat(items['PrecioRef']))))
			//5jun18	{
			//5jun18		licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strPrecioNoNumerico +'<br/>';
			//5jun18	}

			//	TipoIVA
			if ((requiereIVA=='S') && (isNaN(parseFloat(items['TipoIVA']))))
			{
				licAvisosCarga += '('+(i+1)+') '+RefEstandar+': '+strTipoIVAObligatorio +'<br/>';
			}
			
			//	Grupo de stock: por ahora solo para UNIMED
			if ((GrupoStock!='')&&(GrupoStock!='REFERENCIA')&&(GrupoStock!='GENERICO')&&(GrupoStock!='SIMILAR'))
			{
				licAvisosCarga += '('+(i+1)+') '+RefEstandar+': '+strGrupoStockIncorrecto +'<br/>';
			}
			
				
 			ficProductos.push(items);

			//solodebug
			console.log('Leyendo IDCliente:'+IDCliente+' Prod: ('+items['RefEstandar']+') '+items['Nombre']+'. PrecioRef:'+items['PrecioRef']);

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
		
		ficControlErrores=EnviarFicheroProdEstandar(ficProductos);
	
	}
	else
	{
		alert(str_ErrSubirProductos);
	}
	
	jQuery("#btnMantenProductos").show();
	jQuery("#TXT_PRODUCTOS").show();
	
}




//	2ene17	recuperamos los datos de ofertas de un proveedor
function prepararEnvioProdEstandar(nombreFichero)
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
			//solodebug	console.log('prepararEnvioProdEstandarFichero: '+objeto);
			//solodebug	ficID=1;
			
			console.log('prepararEnvioProdEstandarFichero ficID:'+data.PrepararEnvio.IDFichero);
			
			ficID=data.PrepararEnvio.IDFichero;
		}
	});
}


//	Enviamos todos los productos al servidor
function EnviarTodosProductosProdEstandar(licNumRegistrosEnviados, ForzarNombre)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosProductosProdEstandar INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

	//	Entrada en el proceso
	
	//solodebug
	console.log('enviarProdEstandar: licNumRegistrosEnviados:'+licNumRegistrosEnviados+' ForzarNombre:'+ForzarNombre+ ' total:'+ficProductos.length);

	if (licNumRegistrosEnviados>=ficProductos.length)
	{

		if (ficControlErrores==0)
		{
			//solodebug	
			console.log('enviarProdEstandar: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length + ' -> cerrarFichero sin errores');
			
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
			console.log('enviarProdEstandar: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length + ' -> cerrarFichero CON ERROR');
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

	var texto	=(licNumRegistrosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumRegistrosEnviados].Referencia+'] '+ficProductos[licNumRegistrosEnviados].Nombre;
	
	var otros =//PENDIENTE'CONSUMO:'+ficProductos[licNumRegistrosEnviados].Consumo+
				'REG:'+ficProductos[licNumRegistrosEnviados].Regulado+'|ORDEN:'+ficProductos[licNumRegistrosEnviados].Orden+'|CURVA:'+ficProductos[licNumRegistrosEnviados].CurvaABC
				+'|REGISTRO:'+ficProductos[licNumRegistrosEnviados].Registro+'|FECHACAD:'+ficProductos[licNumRegistrosEnviados].FechaCadRegistro+'|ONCO:'+ficProductos[licNumRegistrosEnviados].Oncologico
				;


	console.log('EnviarTodosProductosProdEstandar. Otros campos:'+otros);
	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/MantenProdEstandarAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumRegistrosEnviados
					+"&IDCLIENTE="+ficProductos[licNumRegistrosEnviados].IDCliente
					+"&REFESTANDAR="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].RefEstandar))
					+"&REFCLIENTE="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].RefCliente))
					+"&NOMBRE="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].Nombre))
					+"&PRINCIPIOACTIVO="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].PrincipioActivo))
					+"&GRUPODESTOCK="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].GrupoStock))
					+"&MARCAS="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].Marcas))
					+"&UDBASICA="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].UdBasica))
					+"&PRECIOREF="+ficProductos[licNumRegistrosEnviados].PrecioRef
					+"&TIPOIVA="+ficProductos[licNumRegistrosEnviados].TipoIVA
					+"&OTROS="+encodeURIComponent(ScapeHTMLString(otros))
					+"&FORZARNOMBRE="+ForzarNombre,
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			ficError='ERROR_ENVIANDO';
			//licLineaError=numLineaInicio;
			
			ficControlErrores+=ficControlErrores+str_NoPodidoIncluirProducto;	//+': ('+ficProductos[licNumRegistrosEnviados].RefEstandar+') '+ficProductos[licNumRegistrosEnviados].Nombre+'<br/>';
			console.log('enviarProdEstandar [ERROR1]: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length+ ' => ERROR enviando:'+objeto+':'+quepaso+':'+otroobj);
			return 'ERROR';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			
			//
			//	Control de errores en la funcion que llama a esta
			//
						
			ficProductos[licNumRegistrosEnviados].IDProducto=data.EnviarLinea.idproducto;

			//	debug
			console.log('enviarProdEstandar: res:'||data.EnviarLinea.estado);
			
			//	Procesar error
			if (data.EnviarLinea.estado!='OK')
			{
				console.log('enviarProdEstandar [ERROR2]. ERROR ENVIANDO: ('+ficProductos[licNumRegistrosEnviados].RefEstandar+') '+ficProductos[licNumRegistrosEnviados].Nombre);
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+ficProductos[licNumRegistrosEnviados].RefEstandar+') '+ficProductos[licNumRegistrosEnviados].Nombre+':'+data.EnviarLinea.estado+'<br/>';
				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarProdEstandar: ENVIO CORRECTO. IDProdEstandar:'+data.EnviarLinea.idproducto+' -> ('+ficProductos[licNumRegistrosEnviados].RefEstandar+') '+ficProductos[licNumRegistrosEnviados].Nombre);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			}

			//console.log('enviarProdEstandar: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumRegistrosEnviados].RefEstandar+') '+ficProductos[licNumRegistrosEnviados].Nombre);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			EnviarTodosProductosProdEstandar(licNumRegistrosEnviados, ForzarNombre);		

		}
	});
	
}


//	3mar17	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
function EnviarFicheroProdEstandar(ficProductos)
{
	var ficControlErrores='';
	var d= new Date();


	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero.';
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvioProdEstandar('MANTENPRODESTANDAR_'+IDUsuario+'_'+d.getYear()+d.getMonth()+d.getDay()+d.getHours()+d.getMinutes()+d.getSeconds());

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
			
		if (jQuery('#chkForzar').is(':checked')) ForzarNombre='S';				//	30jun22 antes:.attr('checked')
		
		console.log('EnviarFicheroProdEstandar. ID checkbox:'+jQuery('#chkForzar').attr('id') +'> ForzarNombre:'+ForzarNombre);
	
	
		
		//	Version recursiva
		EnviarTodosProductosProdEstandar(0, ForzarNombre);
		
	}
	else
	{
		document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: ERROR:'+ficControlErrores;
	}

	return ficControlErrores;
}










//
//	Mantenimiento del catálogo de proveedores
//


//	Funcion principal para recuperar, comprobar y enviar los productos
function MantenCatProveedoresTXT()
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';
	
	var IDCliente = oForm.elements['FIDEMPRESA'].value;

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
		var CodProveedor,Referencia,Nombre,Marca,UdBasica,UdesLote,Precio, TipoIVA=0, RefPack, Cantidad, CodExpediente='', CodIUM='', CodCUM='', CodInvima='', FechaInvima='', ClasRiesgo='',
				FechaInicioTrf='', FechaFinalTrf='', DocTarifa='', TipoNegociacion='';
		var Producto= Piece(CadenaCambios, '·',i);

		//solodebug	alert('['+Producto+']');
		
		col=0;
		if (requiereProveedor=='S')
		{
			CodProveedor = Piece(Producto, sepCampos, 0);
			++col;
		}
			
		Referencia	= Piece(Producto, sepCampos, col);
		++col;
		Nombre		= Piece(Producto, sepCampos, col);
		++col;
		Marca		= Piece(Producto, sepCampos, col);
		++col;
		UdBasica	= Piece(Producto, sepCampos, col);
		++col;
		UdesLote	= Piece(Producto, sepCampos, col);
		++col;
		Precio		= Piece(Producto, sepCampos, col);
		++col;
		
		if (requiereIVA=='S')
		{
			TipoIVA = Piece(Producto, sepCampos, col);
			++col;
		}

		if (requiereDatosAdicionalesCol=='S')
		{
			CodExpediente = Piece(Producto, sepCampos, col);
			++col;
			CodIUM = Piece(Producto, sepCampos, col);
			++col;
			CodCUM = Piece(Producto, sepCampos, col);
			++col;
			CodInvima = Piece(Producto, sepCampos, col);
			++col;
			FechaInvima = Piece(Producto, sepCampos, col);
			++col;
			ClasRiesgo = Piece(Producto, sepCampos, col);
			++col;
		}
		
		RefPack		= Piece(Producto, sepCampos, col);
		++col;
		Cantidad	= Piece(Producto, sepCampos, col);
		++col;
		FechaInicioTrf	= Piece(Producto, sepCampos, col);
		++col;
		FechaFinalTrf	= Piece(Producto, sepCampos, col);
		++col;
		DocTarifa	= Piece(Producto, sepCampos, col);
		++col;
		TipoNegociacion	= Piece(Producto, sepCampos, col);
		++col;
		AreaGeo	= Piece(Producto, sepCampos, col);
		++col;
		CodDivisa	= Piece(Producto, sepCampos, col);
		++col;
		CantBonif	= Piece(Producto, sepCampos, col);
		++col;
		CantGratis	= Piece(Producto, sepCampos, col);


		//solodebug		
		console.log('MantenProductosTXT. Linea ('+i+'). CodProveedor:'+CodProveedor+'. Ref:'+Referencia+'. Prod:'+Nombre
			+'. UdBasica:'+UdBasica+'. UdesLote:'+UdesLote+'. Precio:'+Precio+'. TipoIVA:'+TipoIVA+'. CodInvima:'+CodInvima+'. RefPack:'+RefPack
			+'. FechaInicioTrf:'+FechaInicioTrf+'. FechaFinalTrf:'+FechaFinalTrf+'. DocTarifa:'+DocTarifa+'. AreaGeo:'+AreaGeo
			+'. CodDivisa:'+CodDivisa+'. CantBonif:'+CantBonif+'. CantGratis:'+CantGratis
			);

		if ((Referencia!='')||(Nombre!=''))		//	Eliminamos líneas vacias
		{
			var items		= [];
			items['IDCliente']	= IDCliente;
			items['CodProveedor']	= CodProveedor;
			items['Referencia']	= Referencia;
			items['Nombre'] = Nombre;
			items['Marca'] = Marca;
			items['UdBasica'] = UdBasica;
			items['UdesLote'] = UdesLote;
			items['Precio'] = Precio.replace(/\./g,"");		//	Eliminamos los puntos (separador de miles)
			items['TipoIVA'] = TipoIVA;

			items['CodExpediente'] = CodExpediente;
			items['CodIUM'] = CodIUM;
			items['CodCUM'] = CodCUM;
			items['CodInvima'] = CodInvima;
			items['FechaInvima'] = FechaInvima;
			items['ClasRiesgo'] = ClasRiesgo;

			items['RefPack'] = RefPack;
			items['Cantidad'] = Cantidad;

			//	5oct20 Nuevos campos para completar info de TARIFA
			items['FechaInicioTrf'] = FechaInicioTrf;
			items['FechaFinalTrf'] = FechaFinalTrf;
			items['DocTarifa'] = DocTarifa;
			items['TipoNegociacion'] = TipoNegociacion;
			
			//	10nov20 Nuevos campos
			items['AreaGeo'] = AreaGeo;
			items['CodDivisa'] = CodDivisa;
			items['CantBonif'] = CantBonif;
			items['CantGratis'] = CantGratis;
			
			items['IDProducto'] = '';							//	inicializaremos vía ajax


			//	Comprobar campos obligatorios
			//	Cod Proveedor
			if ((requiereProveedor=='S') && (CodProveedor==''))
			{
				//solodebug licAvisosCarga += 'conterr1';
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strCodProveedorObligatorio +'<br/>';
			}
			
			//	Referencia
			if (Referencia=='')
			{
				//solodebug licAvisosCarga += 'conterr2';
				licAvisosCarga += '('+(i+1)+') '+Nombre+': '+strReferenciaObligatoria +'<br/>';
			}
			
			//	Nombre
			if (Nombre=='')
			{
				//solodebug licAvisosCarga += 'conterr3';
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
				//solodebug licAvisosCarga += 'conterr4';
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strCampoObligatorio.replace('[[CAMPO]]',ncUdBasica) +'<br/>';

			}

			//	Udes/lote
			if (isNaN(parseFloat(items['UdesLote'])))
			{
				//solodebug licAvisosCarga += 'conterr5';
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strUdesLoteNoNumerico +'<br/>';
			}

			//	Precio
			if ((items['Precio']!='')&&(isNaN(parseFloat(items['Precio']))))
			{
				//solodebug licAvisosCarga += 'conterr6';
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strPrecioNoNumerico +'<br/>';
			}

			//	TipoIVA
			if ((requiereIVA=='S') && (items['TipoIVA']!='')&&(isNaN(parseFloat(items['TipoIVA']))))
			{
				//solodebug licAvisosCarga += 'conterr7';
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strCampoObligatorio.replace('[[CAMPO]]',ncIVA) +' ['+items['TipoIVA']+']<br/>';
			}

			//	Cantidad obligatoria si está ref pack informada
			console.log('Control pack. RefPack:'+RefPack+' Cant:'+items['Cantidad']);
			if ((RefPack!='') &&(isNaN(parseFloat(items['Cantidad']))))
			{
				console.log('Control pack. RefPack:'+RefPack+' Cant:'+items['Cantidad']+'. ERROR');
				//solodebug licAvisosCarga += 'conterr8';
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strCantidadObligatoria +'<br/>';
			}

			//	5oct20 FechaInicioTrf
			if ((items['FechaInicioTrf']!='')&&(CheckDate(items['FechaInicioTrf'])!=''))
			{
				//solodebug licAvisosCarga += 'conterr9';
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strFechaIncorrecta +': '+ items['FechaInicioTrf'] +'<br/>';
			}

			//	5oct20 FechaFinalTrf
			if ((items['FechaFinalTrf']!='')&&(CheckDate(items['FechaFinalTrf'])!=''))
			{
				//solodebug licAvisosCarga += 'conterr10';
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strFechaIncorrecta +': '+ items['FechaFinalTrf']+'<br/>';
			}

			//	Bonificación: CantBonif
			if ((items['CantBonif']!='')&&(isNaN(parseInt(items['CantBonif']))))
			{
				//solodebug licAvisosCarga += 'conterr11';
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strCantBonifNoNumerico +'<br/>';
			}

			//	Bonificación: CantGratis
			if ((items['CantGratis']!='')&&(isNaN(parseInt(items['CantGratis']))))
			{
				//solodebug licAvisosCarga += 'conterr12';
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strCantGratisNoNumerico +'<br/>';
			}

			//	CodDivisa
			if ((items['CodDivisa']!='')&&(CodDivisa!='EUR')&&(CodDivisa!='BRL')&&(CodDivisa!='COP')&&(CodDivisa!='USD'))
			{
				//solodebug licAvisosCarga += 'conterr13';
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strCodDivisaIncorrecto +'<br/>';
			}
				
			/*


				Pendiente: tipo IVA, etc.
			
			
			*/
			
			/*
			if (items['Cantidad'].indexOf(',')!=-1)
			{
				var CantidadOld=items['Cantidad'];
				items['Cantidad']=String(parseInt(items['Cantidad'].replace(",","."))+1);
				licAvisosCarga += items['RefCliente']+': '+items['Descripcion']+'. '+str_CambioCantidad.replace('[[CANTIDADOLD]]',CantidadOld).replace('[[CANTIDADNEW]]',items['Cantidad']) +'\n\r';
			}
			*/

 			ficProductos.push(items);

			//solodebug
			console.log('MantenProductosTXT. Linea ('+i+'). INCLUIDA LINEA. IDCliente:'+IDCliente+ ' CodProveedor:'+CodProveedor+' Prod: ('+items['Referencia']+') '+items['Nombre']+'. Precio:'+items['Precio']);

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
		
		ficControlErrores=EnviarFicheroCatProv(ficProductos);
	
	}
	else
	{
		alert(str_ErrSubirProductos);
	}
	
	jQuery("#btnMantenProductos").show();
	jQuery("#TXT_PRODUCTOS").show();
	
}




//	2ene17	recuperamos los datos de ofertas de un proveedor
function prepararEnvioCatProv(nombreFichero)
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
			//solodebug	console.log('prepararEnvioCatProvFichero: '+objeto);
			//solodebug	ficID=1;
			
			console.log('prepararEnvioCatProvFichero ficID:'+data.PrepararEnvio.IDFichero);
			
			ficID=data.PrepararEnvio.IDFichero;
		}
	});
}


//	Enviamos todos los productos al servidor
function EnviarTodosProductosCatProv(licNumRegistrosEnviados, ForzarNombre)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosProductosCatProv INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

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

	var texto	=(licNumRegistrosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumRegistrosEnviados].Referencia+'] '+ficProductos[licNumRegistrosEnviados].Nombre;

	var Otros=ficProductos[licNumRegistrosEnviados].CodExpediente+'|'
				+ficProductos[licNumRegistrosEnviados].CodIUM+'|'
				+ficProductos[licNumRegistrosEnviados].CodCUM+'|'
				+ficProductos[licNumRegistrosEnviados].CodInvima+'|'
				+ficProductos[licNumRegistrosEnviados].FechaInvima+'|'
				+ficProductos[licNumRegistrosEnviados].ClasRiesgo+'|'
				+ficProductos[licNumRegistrosEnviados].FechaInicioTrf+'|'
				+ficProductos[licNumRegistrosEnviados].FechaFinalTrf+'|'
				+ficProductos[licNumRegistrosEnviados].DocTarifa+'|'
				+ficProductos[licNumRegistrosEnviados].TipoNegociacion+'|'
				+ficProductos[licNumRegistrosEnviados].AreaGeo+'|'
				+ficProductos[licNumRegistrosEnviados].CodDivisa+'|'					//	21dic20
				+ficProductos[licNumRegistrosEnviados].CantBonif+'|'
				+ficProductos[licNumRegistrosEnviados].CantGratis+'|'
				;
	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/MantenProductoAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumRegistrosEnviados
					+"&IDCLIENTE="+ficProductos[licNumRegistrosEnviados].IDCliente
					+"&CODNITPROVEEDOR="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].CodProveedor)
					+"&REFERENCIA="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].Referencia)
					+"&NOMBRE="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].Nombre))
					+"&MARCA="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].Marca))
					+"&UDBASICA="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].UdBasica))
					+"&UDESLOTE="+ficProductos[licNumRegistrosEnviados].UdesLote
					+"&PRECIO="+ficProductos[licNumRegistrosEnviados].Precio
					+"&TIPOIVA="+ficProductos[licNumRegistrosEnviados].TipoIVA
					+"&OTROS="+encodeURIComponent(ScapeHTMLString(Otros))		
					+"&REFPACK="+ficProductos[licNumRegistrosEnviados].RefPack
					+"&CANTIDAD="+ficProductos[licNumRegistrosEnviados].Cantidad
					+"&FORZARNOMBRE="+ForzarNombre+"&_="+d.getTime(),
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
				console.log('enviarLineaFichero [ERROR2]. ERROR ENVIANDO: ('+ficProductos[licNumRegistrosEnviados].Referencia+') '+ficProductos[licNumRegistrosEnviados].Nombre);
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+ficProductos[licNumRegistrosEnviados].Referencia+') '+ficProductos[licNumRegistrosEnviados].Nombre+':'+data.EnviarLinea.estado+'<br/>';
				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDLineaMO:'+data.EnviarLinea.idproducto+' -> ('+ficProductos[licNumRegistrosEnviados].Referencia+') '+ficProductos[licNumRegistrosEnviados].Nombre);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			}

			//console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumRegistrosEnviados].Codigo+') '+ficProductos[licNumRegistrosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			EnviarTodosProductosCatProv(licNumRegistrosEnviados, ForzarNombre);		

		}
	});
	
}


//	3mar17	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
function EnviarFicheroCatProv(ficProductos)
{
	var ficControlErrores='';
	var d= new Date();


	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero.';
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvioCatProv('MANTENPRODUCTOS_'+IDUsuario+'_'+d.getYear()+d.getMonth()+d.getDay()+d.getHours()+d.getMinutes()+d.getSeconds());

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
		
		if (jQuery('#chkForzar').is(':checked')) ForzarNombre='S';				//	30jun22 antes:.attr('checked')
		
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

















//
//	Adjudicación de productos
//


//	Funcion principal para recuperar, comprobar y enviar los productos
function AdjudicacionTXT()
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';
	
	var IDCliente = oForm.elements['FIDEMPRESA'].value;

	//solodebug	var Control='';

	var Referencias	= oForm.elements['TXT_PRODUCTOS'].value;
	Referencias	= Referencias.replace(/[\t]/g, sepCampos);			// 	Tabulador para separar columnas en excel -> '|'

	ProcesarAdjudicacionTXT(Referencias);
}



//	Funcion principal para recuperar, comprobar y enviar los productos
function ProcesarAdjudicacionTXT(CadenaCambios)
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
		CodProveedor= Piece(Producto, sepCampos, col);
		++col;
		RefProveedor= Piece(Producto, sepCampos, col);
		++col;
		Orden	= Piece(Producto, sepCampos, col);

		//solodebug		
		console.log('ProcesarAdjudicacionTXT. Linea ('+i+'). RefCliente:'+RefCliente+'. CodProveedor:'+CodProveedor+'. RefProveedor:'+RefProveedor+'. Orden:'+Orden);

		if ((RefCliente!='')&&(CodProveedor!='')&&(RefProveedor!=''))		//	Eliminamos líneas vacias
		{
			var items		= [];
			items['IDCliente']	= IDCliente;
			items['RefCliente']	= RefCliente;
			items['CodProveedor']	= CodProveedor;
			items['RefProveedor']	= RefProveedor;
			items['Orden'] = Orden;
			
			items['IDProdEstandar'] = '';							//	inicializaremos vía ajax


			//	Comprobar campos obligatorios
			//	Cod Proveedor
			if (CodProveedor=='')
			{
				licAvisosCarga += '('+(i+1)+') '+RefCliente+': '+strCodProveedorObligatorio +'<br/>';
			}
			
			//	Referencia
			if (RefCliente=='')
			{
				licAvisosCarga += '('+(i+1)+') '+CodProveedor+':'+RefProveedor+': '+strReferenciaObligatoria +'<br/>';
			}
			
			//	Nombre
			if (RefProveedor=='')
			{
				licAvisosCarga += '('+(i+1)+') '+RefCliente+': '+strReferenciaObligatoria +'<br/>';
			}

 			ficProductos.push(items);

			//solodebug
			console.log('Leyendo IDCliente:'+IDCliente+' RefCliente:'+ RefCliente+ ' CodProveedor:'+CodProveedor+' RefProveedor:'+RefProveedor);

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
		
		ficControlErrores=EnviarFicheroAdjudicacion(ficProductos);
	
	}
	else
	{
		alert(str_ErrSubirProductos);
	}
	
	jQuery("#btnMantenProductos").show();
	jQuery("#TXT_PRODUCTOS").show();
	
}




//	2ene17	recuperamos los datos de ofertas de un proveedor
function prepararEnvioAdjudicacion(nombreFichero)
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
			//solodebug	console.log('prepararEnvioAdjudicacionFichero: '+objeto);
			//solodebug	ficID=1;
			
			console.log('prepararEnvioAdjudicacionFichero ficID:'+data.PrepararEnvio.IDFichero);
			
			ficID=data.PrepararEnvio.IDFichero;
		}
	});
}


//	Enviamos todos los productos al servidor
function EnviarTodosAdjudicacion(licNumRegistrosEnviados)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosAdjudicacion INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

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

	var texto	=(licNumRegistrosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumRegistrosEnviados].RefCliente+'] '+ficProductos[licNumRegistrosEnviados].CodProveedor+':'+ficProductos[licNumRegistrosEnviados].RefProveedor;
	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/AdjudicacionAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumRegistrosEnviados
					+"&IDCLIENTE="+ficProductos[licNumRegistrosEnviados].IDCliente
					+"&REFCLIENTE="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefCliente)
					+"&CODNITPROVEEDOR="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].CodProveedor)
					+"&REFPROVEEDOR="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefProveedor)
					+"&ORDEN="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].Orden)
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
			EnviarTodosAdjudicacion(licNumRegistrosEnviados);		

		}
	});
	
}


//	3mar17	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
function EnviarFicheroAdjudicacion(ficProductos)
{
	var ficControlErrores='';
	var d= new Date();


	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero.';
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvioAdjudicacion('ADJUDICACION_'+IDUsuario+'_'+d.getYear()+d.getMonth()+d.getDay()+d.getHours()+d.getMinutes()+d.getSeconds());

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
		EnviarTodosAdjudicacion(0);
		
	}
	else
	{
		document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: ERROR:'+ficControlErrores;
	}

	return ficControlErrores;
}














//
//	Homologacion de productos
//


//	Funcion principal para recuperar, comprobar y enviar los productos
function HomologacionTXT()
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';
	
	var IDCliente = oForm.elements['FIDEMPRESA'].value;

	//solodebug	var Control='';

	var Referencias	= oForm.elements['TXT_PRODUCTOS'].value;
	Referencias	= Referencias.replace(/[\t]/g, sepCampos);			// 	Tabulador para separar columnas en excel -> '|'

	ProcesarHomologacionTXT(Referencias);
}



//	Funcion principal para recuperar, comprobar y enviar los productos
function ProcesarHomologacionTXT(CadenaCambios)
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
		var CodCentro,RefCentro,RefCliente,CodProveedor,RefProveedor,Orden,UdBasica,PrecioRef='';
		var Producto= Piece(CadenaCambios, '·',i);

		//solodebug	alert('['+Producto+']');
//Cod/NIF/NIT Centro|Ref.Centro|Ref.Cliente|Cod/NIF/NIT Proveedor|Ref.Proveedor[|Orden]		

		col=0;

		CodCentro	= Piece(Producto, sepCampos, col);
		++col;
		RefCentro	= Piece(Producto, sepCampos, col);
		++col;
		RefCliente	= Piece(Producto, sepCampos, col);
		++col;
		CodProveedor= Piece(Producto, sepCampos, col);
		++col;
		RefProveedor= Piece(Producto, sepCampos, col);
		++col;
		Autorizado= Piece(Producto, sepCampos, col);
		++col;
		Orden	= Piece(Producto, sepCampos, col);
		++col;
		UdBasica	= Piece(Producto, sepCampos, col);
		++col;
		PrecioRef	= Piece(Producto, sepCampos, col);

		//solodebug		
		console.log('ProcesarHomologacionTXT. Linea ('+i+'). RefCliente:'+RefCliente+'. CodProveedor:'+CodProveedor+'. RefProveedor:'+RefProveedor+'. Autorizado:'+Autorizado+'. Orden:'+Orden
				+'. UdBasica:'+UdBasica+'. PrecioRef:'+PrecioRef);

		if (CodCentro!='')		//	Eliminamos líneas vacias
		{
			var items		= [];
			items['IDCliente']	= IDCliente;
			items['CodCentro']	= CodCentro;
			items['RefCentro']	= RefCentro;
			items['RefCliente']	= RefCliente;
			items['CodProveedor']	= CodProveedor;
			items['RefProveedor']	= RefProveedor;
			items['Autorizado']	= Autorizado;
			items['Orden'] = Orden;
			items['UdBasica'] = UdBasica;
			items['PrecioRef'] = PrecioRef;
			
			items['IDProdEstandar'] = '';							//	inicializaremos vía ajax


			//	Comprobar campos obligatorios
			//	Cod centro
			if (CodCentro=='')
			{
				licAvisosCarga += '('+(i+1)+') '+RefCliente+': '+strCodCentroObligatorio +'<br/>';
			}

			//	Ref.centro
			if (RefCentro=='')
			{
				licAvisosCarga += '('+(i+1)+') '+RefCliente+': '+strRefCentroObligatorio +'<br/>';
			}
			
			//	Referencia
			if (RefCliente=='')
			{
				licAvisosCarga += '('+(i+1)+') '+CodProveedor+':'+RefProveedor+': '+strReferenciaObligatoria +'<br/>';
			}

			//	29ago19 Datos de proveedor opcionales
			//	Cod Proveedor
			//	if (CodProveedor=='')
			//	{
			//		licAvisosCarga += '('+(i+1)+') '+RefCliente+': '+strCodProveedorObligatorio +'<br/>';
			//	}
			
			//	RefProveedor
			if ((CodProveedor!='')&&(RefProveedor==''))
			{
				licAvisosCarga += '('+(i+1)+') '+RefCliente+': '+strReferenciaObligatoria +'<br/>';
			}

			//	Autorizado
			if ((CodProveedor!='')&&(Autorizado!='S')&&(Autorizado!='N'))
			{
				licAvisosCarga += '('+(i+1)+') '+RefCliente+': '+strAutorizadoSoN +'<br/>';
			}

 			ficProductos.push(items);

			//solodebug
			console.log('Leyendo IDCliente:'+IDCliente+' RefCliente:'+ RefCliente+ ' CodProveedor:'+CodProveedor+' RefProveedor:'+RefProveedor+' Autorizado:'+Autorizado);

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
		
		ficControlErrores=EnviarFicheroHomologacion(ficProductos);
	
	}
	else
	{
		alert(str_ErrSubirProductos);
	}
	
	jQuery("#btnMantenProductos").show();
	jQuery("#TXT_PRODUCTOS").show();
	
}




//	2ene17	recuperamos los datos de ofertas de un proveedor
function prepararEnvioHomologacion(nombreFichero)
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
			//solodebug	console.log('prepararEnvioHomologacionFichero: '+objeto);
			//solodebug	ficID=1;
			
			console.log('prepararEnvioHomologacionFichero ficID:'+data.PrepararEnvio.IDFichero);
			
			ficID=data.PrepararEnvio.IDFichero;
		}
	});
}


//	Enviamos todos los productos al servidor
function EnviarTodosHomologacion(licNumRegistrosEnviados)
{
	var d= new Date();
	
	//solodebug	alert("EnviarTodosHomologacion INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

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

	var texto	=(licNumRegistrosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumRegistrosEnviados].RefCliente+':'+ficProductos[licNumRegistrosEnviados].RefCentro+'] '
			+((ficProductos[licNumRegistrosEnviados].CodProveedor=='')?'':ficProductos[licNumRegistrosEnviados].CodProveedor+':'+ficProductos[licNumRegistrosEnviados].RefProveedor);
	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/HomologacionAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumRegistrosEnviados
					+"&IDCLIENTE="+ficProductos[licNumRegistrosEnviados].IDCliente
					+"&CODCENTRO="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].CodCentro)
					+"&REFCENTRO="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefCentro)
					+"&REFCLIENTE="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefCliente)
					+"&CODNITPROVEEDOR="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].CodProveedor)
					+"&REFPROVEEDOR="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefProveedor)
					+"&AUTORIZADO="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].Autorizado)
					+"&ORDEN="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].Orden)
					+"&UDBASICA="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].UdBasica)
					+"&PRECIOREF="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].PrecioRef)
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
				console.log('enviarLineaFichero [ERROR2]. ERROR ENVIANDO:'+texto);
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+ficProductos[licNumRegistrosEnviados].RefCentro+'):'+data.EnviarLinea.estado+'<br/>';
				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDLineaMO:'+data.EnviarLinea.idproducto+' -> '+texto);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			}

			//console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumRegistrosEnviados].Codigo+') '+ficProductos[licNumRegistrosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			EnviarTodosHomologacion(licNumRegistrosEnviados);		

		}
	});
	
}


//	3mar17	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
function EnviarFicheroHomologacion(ficProductos)
{
	var ficControlErrores='';
	var d= new Date();


	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero.';
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvioHomologacion('Homologacion_'+IDUsuario+'_'+d.getYear()+d.getMonth()+d.getDay()+d.getHours()+d.getMinutes()+d.getSeconds());

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
		EnviarTodosHomologacion(0);
		
	}
	else
	{
		document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: ERROR:'+ficControlErrores;
	}

	return ficControlErrores;
}














//
//	Precios de referencia
//


//	Funcion principal para recuperar, comprobar y enviar los productos
function PreciosReferenciaTXT()
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';
	
	var IDCliente = oForm.elements['FIDEMPRESA'].value;

	//solodebug	var Control='';

	var Referencias	= oForm.elements['TXT_PRODUCTOS'].value;
	Referencias	= Referencias.replace(/[\t]/g, sepCampos);			// 	Tabulador para separar columnas en excel -> '|'

	ProcesarPreciosReferenciaTXT(Referencias);
}



//	Funcion principal para recuperar, comprobar y enviar los productos
function ProcesarPreciosReferenciaTXT(CadenaCambios)
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
		var RefCliente,PrecioRef;
		var Producto= Piece(CadenaCambios, '·',i);

		//solodebug	alert('['+Producto+']');

		col=0;
		RefCliente	= Piece(Producto, sepCampos, col);
		++col;
		PrecioRef= Piece(Producto, sepCampos, col);

		//solodebug		
		console.log('ProcesarPreciosReferenciaTXT. Linea ('+i+'). RefCliente:'+RefCliente+'. PrecioRef:'+PrecioRef);

		if ((RefCliente!='')||(PrecioRef!=''))		//	Eliminamos líneas vacias
		{
			var items		= [];
			items['IDCliente']	= IDCliente;
			items['RefCliente']	= RefCliente;
			items['PrecioRef'] = PrecioRef;
			
			items['IDProdEstandar'] = '';							//	inicializaremos vía ajax


			//	Comprobar campos obligatorios
			//	Cod Proveedor
			//	Ref.cliente
			if (RefCliente=='')
			{
				licAvisosCarga += '('+(i+1)+') '+RefCliente+': '+strRefClienteObligatoria +'<br/>';
			}

			//	Precio de referencia
			if (PrecioRef=='')
			{
				licAvisosCarga += '('+(i+1)+') '+RefCliente+': '+strPrecioObligatorio +'<br/>';
			}

 			ficProductos.push(items);

			//solodebug
			console.log('Leyendo RefCliente:'+ RefCliente+ ' PrecioRef:'+PrecioRef);

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
		
		ficControlErrores=EnviarFicheroPreciosReferencia(ficProductos);
	
	}
	else
	{
		alert(str_ErrSubirProductos);
	}
	
	jQuery("#btnMantenProductos").show();
	jQuery("#TXT_PRODUCTOS").show();
	
}




//	2ene17	recuperamos los datos de ofertas de un proveedor
function prepararEnvioPreciosReferencia(nombreFichero)
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
			//solodebug	console.log('prepararEnvioPreciosReferenciaFichero: '+objeto);
			//solodebug	ficID=1;
			
			console.log('prepararEnvioPreciosReferenciaFichero ficID:'+data.PrepararEnvio.IDFichero);
			
			ficID=data.PrepararEnvio.IDFichero;
		}
	});
}


//	Enviamos todos los productos al servidor
function EnviarTodosPreciosReferencia(licNumRegistrosEnviados)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosPreciosReferencia INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

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

	var texto	=(licNumRegistrosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumRegistrosEnviados].RefCliente+'] '+ficProductos[licNumRegistrosEnviados].CodProveedor+':'+ficProductos[licNumRegistrosEnviados].v;
	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/PreciosReferenciaAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumRegistrosEnviados
					+"&IDCLIENTE="+ficProductos[licNumRegistrosEnviados].IDCliente
					+"&REFCLIENTE="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefCliente)
					+"&PRECIOREF="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].PrecioRef)
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
				console.log('enviarLineaFichero [ERROR2]. ERROR ENVIANDO: ('+ficProductos[licNumRegistrosEnviados].RefCliente)+')';
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+ficProductos[licNumRegistrosEnviados].RefCliente+'):'+data.EnviarLinea.estado+'<br/>';
				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDLineaMO:'+data.EnviarLinea.idproducto+' -> '+ficProductos[licNumRegistrosEnviados].Referencia);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			}

			//console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumRegistrosEnviados].Codigo+') '+ficProductos[licNumRegistrosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			EnviarTodosPreciosReferencia(licNumRegistrosEnviados);		

		}
	});
	
}


//	3mar17	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
function EnviarFicheroPreciosReferencia(ficProductos)
{
	var ficControlErrores='';
	var d= new Date();


	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero.';
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvioPreciosReferencia('PreciosReferencia_'+IDUsuario+'_'+d.getYear()+d.getMonth()+d.getDay()+d.getHours()+d.getMinutes()+d.getSeconds());

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
		EnviarTodosPreciosReferencia(0);
		
	}
	else
	{
		document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: ERROR:'+ficControlErrores;
	}

	return ficControlErrores;
}







//
//	Identificar productos en cat. privado
//


//	Funcion principal para recuperar, comprobar y enviar los productos
function IdentificarProductosTXT()
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';
	
	var IDCliente = oForm.elements['FIDEMPRESA'].value;

	//solodebug	var Control='';

	var Referencias	= oForm.elements['TXT_PRODUCTOS'].value;
	Referencias	= Referencias.replace(/[\t]/g, sepCampos);			// 	Tabulador para separar columnas en excel -> '|'

	ProcesarIdentificarProductosTXT(Referencias);
}



//	Funcion principal para recuperar, comprobar y enviar los productos
function ProcesarIdentificarProductosTXT(CadenaCambios)
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
		var RefCliente,PrecioRef;
		var Producto= Piece(CadenaCambios, '·',i);

		//solodebug	alert('['+Producto+']');

		col=0;
		NIFProveedor	= Piece(Producto, sepCampos, col);
		++col;
		RefProveedor= Piece(Producto, sepCampos, col);
		++col;
		Precio= Piece(Producto, sepCampos, col);
		++col;
		Cantidad= Piece(Producto, sepCampos, col);
		++col;
		Nombre= Piece(Producto, sepCampos, col);

		//solodebug		
		console.log('ProcesarIdentificarProductosTXT. Linea ('+i+'). NIFProveedor:'+NIFProveedor+'. RefProveedor:'+RefProveedor+'. Precio:'+Precio+'. Cantidad:'+Cantidad+'. Producto:'+Nombre);

		if ((NIFProveedor!='')||(RefProveedor!=''))		//	Eliminamos líneas vacias
		{
			var items		= [];
			items['IDCliente']	= IDCliente;
			items['NIFProveedor']	= NIFProveedor;
			items['RefProveedor']	= RefProveedor;
			items['Precio']	= Precio;
			items['Cantidad']	= Cantidad;
			items['Nombre'] = Nombre;
			
			items['ProdEstandar'] = '';							//	inicializaremos vía ajax


			//	Comprobar campos obligatorios
			//	Cod Proveedor
			//	Ref.cliente
			if (NIFProveedor=='')
			{
				licAvisosCarga += '('+(i+1)+') '+RefProveedor+': '+strCodProveedorObligatorio +'<br/>';
			}

			//	Cod Proveedor
			if (RefProveedor=='')
			{
				licAvisosCarga += '('+(i+1)+') '+NIFProveedor+': '+strPrecioRefObligatorio +'<br/>';
			}

 			ficProductos.push(items);

			//solodebug
			console.log('Leyendo NIFProveedor:'+ NIFProveedor+ ' RefProveedor:'+RefProveedor);

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
		
		ficControlErrores=EnviarFicheroIdentificarProductos(ficProductos);
	
	}
	else
	{
		alert(str_ErrSubirProductos);
	}
	
	jQuery("#btnMantenProductos").show();
	jQuery("#TXT_PRODUCTOS").show();
	
}




//	2ene17	recuperamos los datos de ofertas de un proveedor
function prepararEnvioIdentificarProductos(nombreFichero)
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
			//solodebug	console.log('prepararEnvioPreciosReferenciaFichero: '+objeto);
			//solodebug	ficID=1;
			
			console.log('prepararEnvioPreciosReferenciaFichero ficID:'+data.PrepararEnvio.IDFichero);
			
			ficID=data.PrepararEnvio.IDFichero;
		}
	});
}


//	Enviamos todos los productos al servidor
function EnviarTodosIdentificarProductos(licNumRegistrosEnviados)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosPreciosReferencia INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

	//	Entrada en el proceso
	
	//solodebug
	console.log('enviarLineaFichero: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length);

	if (licNumRegistrosEnviados>=ficProductos.length)
	{
	
		//	Con error o no, muestra el resultado de la exportación
		//	Cabecera para el fichero
		var contenidoCSV='"'+ncNifProveedor+'","'+ncRefProveedor+'","'+ncNombre+'","'+ncRefEstandar+'","'+ncRefCliente+'","'+ncNombreEstandar+'","'
				+ncPrecioCliente+'","'+ncPrecioCentral+'","'+ncCantidad+'","'+ncAhorro+'","'+ncAhorroPorc+'","'+ncOrigen+'"\n';
		
		var TotalCliente=0, TotalCentral=0, TotalAhorro=0, PorcAhorro;
		for (i=0;i<licNumRegistrosEnviados;++i)
		{
			try
			{
				//	recupera los precios
				var cadena=ficProductos[i].ProdEstandar.replace(/::/g,'·');
				var PrecioCliente=parseFloat(ficProductos[i].Precio.replace(".","").replace(",","."));
				var PrecioCentral=parseFloat(Piece(cadena,'·',7).replace(".","").replace(",","."));
				var Cantidad=(ficProductos[i].Cantidad=='')?0:parseFloat(ficProductos[i].Cantidad.replace(".","").replace(",","."));

				contenidoCSV+='"'+ficProductos[i].ProdEstandar.replace(/::/g,'","')+'"\n';
				
				if (Cantidad>0)
				{
					TotalCliente+=PrecioCliente*Cantidad;
					TotalCentral+=PrecioCentral*Cantidad;
					TotalAhorro+=(PrecioCliente-PrecioCentral)*Cantidad;
				}
				else
				{
					TotalCliente+=PrecioCliente;
					TotalCentral+=PrecioCentral;
					TotalAhorro+=(PrecioCliente-PrecioCentral);
				}
			}
			catch(err)
			{
				contenidoCSV+='"'+ficProductos[i].NIFProveedor+'","'+ficProductos[i].RefProveedor+'","'+ficProductos[i].Nombre+'","ERROR"\n';
			}
		}
		
		var AhorroPorc=(TotalCliente==0)?0:100*TotalAhorro/TotalCliente;
		
		
		//	Incluye los totales
		contenidoCSV+='"","","","","","Total:","'+TotalCliente+'","'+TotalCentral+'","","'+TotalAhorro+'","'+AhorroPorc+'"\n';
		//	Quita escapeado HTML
		contenidoCSV=htmlDecode(contenidoCSV);
		
		console.log('contenidoCSV:'+contenidoCSV);
		DescargaMIME(contenidoCSV, 'Informe.csv', 'text/csv;encoding:utf-8');

		if (ficControlErrores==0)
		{
			//solodebug	
			console.log('enviarLineaFichero: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length + ' -> cerrarFichero sin errores');
			
			cerrarFichero(licNumRegistrosEnviados, 'OK');
			jQuery('#infoProgreso').html(str_FicheroProcesado);
			jQuery('#infoProgreso').show();
			jQuery('#infoErrores').hide();
			
			ficID='';		//	Para poder reenviar la carga
			
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

	var texto	=(licNumRegistrosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumRegistrosEnviados].NIFProveedor+'] '+ficProductos[licNumRegistrosEnviados].RefProveedor+' '+ficProductos[licNumRegistrosEnviados].Nombre;
	jQuery('#infoProgreso').html(texto);

	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/IdentificarProductoAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumRegistrosEnviados
					+"&IDCLIENTE="+ficProductos[licNumRegistrosEnviados].IDCliente
					+"&NIFPROVEEDOR="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].NIFProveedor)
					+"&REFPROVEEDOR="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefProveedor)
					+"&PRECIO="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].Precio)
					+"&CANTIDAD="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].Cantidad)
					+"&PRODUCTO="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].Nombre))
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
			
			//texto:
			//	Control de errores en la funcion que llama a esta
			//
						
			ficProductos[licNumRegistrosEnviados].ProdEstandar=data.EnviarLinea.datosProducto;

			//	debug
			console.log('enviarLineaFichero: res:'||data.EnviarLinea.estado);
			
			//	Procesar error
			if (data.EnviarLinea.estado!='OK')
			{
				console.log('enviarLineaFichero [ERROR2]. ERROR ENVIANDO: ('+ficProductos[licNumRegistrosEnviados].RefProveedor)+')';
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='['+ficProductos[licNumRegistrosEnviados].NIFProveedor+'] '+ficProductos[licNumRegistrosEnviados].RefProveedor+':'+data.EnviarLinea.estado+'<br/>';
				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDLineaMO:'+data.EnviarLinea.datosProducto+' -> '+ficProductos[licNumRegistrosEnviados].RefProveedor+' texto:'+texto);

				//jQuery('#infoProgreso').html(texto);

				//sIDCLIENTEolodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			}

			//console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumRegistrosEnviados].Codigo+') '+ficProductos[licNumRegistrosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			EnviarTodosIdentificarProductos(licNumRegistrosEnviados);		

		}
	});
	
}


//	3mar17	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
function EnviarFicheroIdentificarProductos(ficProductos)
{
	var ficControlErrores='';
	var d= new Date();


	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero.';
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvioIdentificarProductos('IdentificarProductos_'+IDUsuario+'_'+d.getYear()+d.getMonth()+d.getDay()+d.getHours()+d.getMinutes()+d.getSeconds());

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
		EnviarTodosIdentificarProductos(0);
		
	}
	else
	{
		document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: ERROR:'+ficControlErrores;
	}

	return ficControlErrores;
}



//
//	21oct19 Carga de proveedores desde fichero
//


//	Funcion principal para recuperar, comprobar y enviar los productos
function ProveedoresTXT()
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';
	
	var IDCliente = oForm.elements['FIDEMPRESA'].value;

	//solodebug	var Control='';

	var Referencias	= oForm.elements['TXT_PRODUCTOS'].value;
	Referencias	= Referencias.replace(/[\t]/g, sepCampos);			// 	Tabulador para separar columnas en excel -> '|'

	ProcesarProveedoresTXT(Referencias);
}



//	Funcion principal para recuperar, comprobar y enviar los productos
function ProcesarProveedoresTXT(CadenaCambios)
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
		var NIFProveedor,Proveedor,NombreCorto,Direccion,Poblacion,Provincia,Barrio,CodPostal,Telf,PlazoEnvio,PlazoEntrega,Usuario,TelUsuario,Email;
		var Empresa= Piece(CadenaCambios, '·',i);

		//solodebug	alert('['+Empresa+']');

		col=0;
		NIFProveedor= Piece(Empresa, sepCampos, col);
		++col;
		Proveedor= Piece(Empresa, sepCampos, col);
		++col;
		NombreCorto= Piece(Empresa, sepCampos, col);
		++col;
		Direccion= Piece(Empresa, sepCampos, col);
		++col;
		Poblacion= Piece(Empresa, sepCampos, col);
		++col;
		Provincia= Piece(Empresa, sepCampos, col);
		++col;
		Barrio= Piece(Empresa, sepCampos, col);
		++col;
		CodPostal= Piece(Empresa, sepCampos, col);
		++col;
		Telf= Piece(Empresa, sepCampos, col);
		++col;
		PlazoEnvio= Piece(Empresa, sepCampos, col);
		++col;
		PlazoEntrega= Piece(Empresa, sepCampos, col);
		++col;
		Usuario= Piece(Empresa, sepCampos, col);
		++col;
		TelUsuario= Piece(Empresa, sepCampos, col);
		++col;
		Email= Piece(Empresa, sepCampos, col);

		//solodebug		
		console.log('ProcesarProveedoresTXT. Linea ('+i+'). NIFProveedor:'+NIFProveedor+'. Proveedor:'+Proveedor+'. NombreCorto:'+NombreCorto+'. Usuario:'+Usuario+'. Email:'+Email);

		if ((NIFProveedor!='')||(Proveedor!=''))		//	Eliminamos líneas vacias
		{
			var items		= [];
			items['NifProveedor']	= NIFProveedor;
			items['Proveedor']	= Proveedor;
			items['NombreCorto']	= NombreCorto;
			items['Direccion']	= Direccion;
			items['Poblacion'] = Poblacion;
			items['Provincia'] = Provincia;
			items['Barrio'] = Barrio;
			items['CodPostal'] = CodPostal;
			items['Telf'] = Telf;
			items['PlazoEnvio'] = PlazoEnvio;
			items['PlazoEntrega'] = PlazoEntrega;
			items['Usuario'] = Usuario;
			items['TelUsuario'] = TelUsuario;
			items['Email'] = Email;
			items['IDEmpresa'] = '';

			//	Comprobar campos obligatorios
			//	Nif Proveedor
			if (NIFProveedor=='')
			{
				licAvisosCarga += '('+(i+1)+') '+Proveedor+': '+strCodProveedorObligatorio +'<br/>';
			}

			//	Proveedor
			if (Proveedor=='')
			{
				licAvisosCarga += '('+(i+1)+') '+NIFProveedor+': '+strProveedorObligatorio +'<br/>';
			}

			//	Direccion
			if (Direccion=='')
			{
				licAvisosCarga += '('+(i+1)+') '+NIFProveedor+': '+strDireccionObligatoria +'<br/>';
			}

			//	Poblacion
			if (Poblacion=='')
			{
				licAvisosCarga += '('+(i+1)+') '+NIFProveedor+': '+strPoblacionObligatoria +'<br/>';
			}

			//	Provincia
			if (Provincia=='')
			{
				licAvisosCarga += '('+(i+1)+') '+NIFProveedor+': '+strProvinciaObligatoria +'<br/>';
			}

			//	CodPostal
			if (CodPostal=='')
			{
				licAvisosCarga += '('+(i+1)+') '+NIFProveedor+': '+strCodPostalObligatorio +'<br/>';
			}

			//	Usuario
			if (Usuario=='')
			{
				licAvisosCarga += '('+(i+1)+') '+NIFProveedor+': '+strUsuarioObligatorio +'<br/>';
			}

			//	Email
			if (Email=='')
			{
				licAvisosCarga += '('+(i+1)+') '+NIFProveedor+': '+strEmailObligatorio +'<br/>';
			}

 			ficProductos.push(items);

			//solodebug
			console.log('Leyendo NIFProveedor:'+ NIFProveedor+ ' Proveedor:'+Proveedor);

		}
		else
		{
			//solodebug
			console.log('Descartando línea en blanco:'+Empresa);
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
		
		ficControlErrores=EnviarFicheroProveedores(ficProductos);
	
	}
	else
	{
		alert(str_ErrSubirProductos);
	}
	
	jQuery("#btnMantenProductos").show();
	jQuery("#TXT_PRODUCTOS").show();
	
}




//	2ene17	recuperamos los datos de ofertas de un proveedor
function prepararEnvioProveedores(nombreFichero)
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
			//solodebug	console.log('prepararEnvioPreciosReferenciaFichero: '+objeto);
			//solodebug	ficID=1;
			
			console.log('prepararEnvioPreciosReferenciaFichero ficID:'+data.PrepararEnvio.IDFichero);
			
			ficID=data.PrepararEnvio.IDFichero;
		}
	});
}


//	Enviamos todos los productos al servidor
function EnviarTodosProveedores(licNumRegistrosEnviados)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosProductosCatProv INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

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

	var texto	=(licNumRegistrosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumRegistrosEnviados].NifProveedor+'] '+ficProductos[licNumRegistrosEnviados].Nombre;

	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/CrearProveedorAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumRegistrosEnviados
					+"&NIFPROVEEDOR="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].NifProveedor)
					+"&NOMBRE="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].Proveedor))
					+"&NOMBRECORTO="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].NombreCorto))
					+"&DIRECCION="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].Direccion))
					+"&POBLACION="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].Poblacion))
					+"&PROVINCIA="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].Provincia))
					+"&BARRIO="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].Barrio))
					+"&CODPOSTAL="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].CodPostal))
					+"&TELEFONO="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].Telf))
					+"&PLAZOENVIO="+ficProductos[licNumRegistrosEnviados].PlazoEnvio
					+"&PLAZOENTREGA="+ficProductos[licNumRegistrosEnviados].PlazoEntrega
					+"&USUARIO="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].Usuario))
					+"&TELUSUARIO="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].TelUsuario))
					+"&EMAIL="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].Email))
					+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			ficError='ERROR_ENVIANDO';
			//licLineaError=numLineaInicio;
			
			ficControlErrores+=ficControlErrores+str_NoPodidoIncluirProducto;
			console.log('enviarLineaFichero [ERROR1]: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length+ ' => ERROR enviando:'+objeto+':'+quepaso+':'+otroobj);
			return 'ERROR';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			
			//
			//	Control de errores en la funcion que llama a esta
			//
						
			ficProductos[licNumRegistrosEnviados].IDEmpresa=data.EnviarLinea.idempresa;

			//	debug
			console.log('enviarLineaFichero: res:'||data.EnviarLinea.estado);
			
			//	Procesar error
			if (data.EnviarLinea.estado!='OK')
			{
				console.log('enviarLineaFichero [ERROR2]. ERROR ENVIANDO: ('+ficProductos[licNumRegistrosEnviados].NifProveedor+') '+ficProductos[licNumRegistrosEnviados].Proveedor);
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+ficProductos[licNumRegistrosEnviados].NifProveedor+') '+ficProductos[licNumRegistrosEnviados].Proveedor+':'+data.EnviarLinea.estado+'<br/>';
				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDLineaMO:'+data.EnviarLinea.idempresa+' -> ('+ficProductos[licNumRegistrosEnviados].NifProveedor+') '+ficProductos[licNumRegistrosEnviados].Proveedor);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			}

			//console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumRegistrosEnviados].Codigo+') '+ficProductos[licNumRegistrosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			EnviarTodosProveedores(licNumRegistrosEnviados);		

		}
	});
	
}


//	3mar17	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
function EnviarFicheroProveedores(ficProductos)
{
	var ficControlErrores='';
	var d= new Date();


	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero.';
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvioProveedores('Proveedores_'+IDUsuario+'_'+d.getYear()+d.getMonth()+d.getDay()+d.getHours()+d.getMinutes()+d.getSeconds());

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
		EnviarTodosProveedores(0);
		
	}
	else
	{
		document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: ERROR:'+ficControlErrores;
	}

	return ficControlErrores;
}







//
//	Carga de fichero Maestro
//


//	Funcion principal para recuperar, comprobar y enviar los productos
function MaestroTXT()
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';

	//solodebug	var Control='';

	var Referencias	= oForm.elements['TXT_PRODUCTOS'].value;
	Referencias	= Referencias.replace(/[\t]/g, sepCampos);			// 	Tabulador para separar columnas en excel -> '|'

	ProcesarMaestroTXT(Referencias);
}



//	Funcion principal para recuperar, comprobar y enviar los productos
function ProcesarMaestroTXT(CadenaCambios)
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
		var NombreCli,NombreMaest,Familia,Subfamilia,Marca;
		var Producto= Piece(CadenaCambios, '·',i);

		//solodebug	alert('['+Producto+']');

		col=0;
		NombreCli	= Piece(Producto, sepCampos, col);
		++col;
		NombreMaest	= Piece(Producto, sepCampos, col);
		++col;
		Familia	= Piece(Producto, sepCampos, col);
		++col;
		Subfamilia	= Piece(Producto, sepCampos, col);
		++col;
		Marca	= Piece(Producto, sepCampos, col);

		//solodebug		
		console.log('ProcesarMaestroTXT. Linea ('+i+'). NombreCli:'+NombreCli+'. NombreMaest:'+NombreMaest);

		if ((NombreCli!='')||(NombreMaest!=''))		//	Eliminamos líneas vacias
		{
			var items		= [];
			items['NombreCli']	= NombreCli;
			items['NombreMaest'] = NombreMaest;
			items['Familia'] = Familia;
			items['Subfamilia'] = Subfamilia;
			items['Marca'] = Marca;
			
			items['IDProducto'] = '';							//	inicializaremos vía ajax


			//	Comprobar campos obligatorios
			if (NombreCli=='')
			{
				licAvisosCarga += '('+(i+1)+') '+NombreMaest+': '+ strNombreProdCliObligatorio+'<br/>';
			}

			if (NombreMaest=='')
			{
				licAvisosCarga += '('+(i+1)+') '+NombreCli+': '+strNombreProdMaestroObligatorio +'<br/>';
			}

 			ficProductos.push(items);

			//solodebug
			console.log('Leyendo: NombreCli:'+NombreCli+'. NombreMaest:'+NombreMaest);

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
	
		jQuery('#infoProgreso').show();
		
		ficControlErrores=EnviarFicheroMaestro(ficProductos);
	
	}
	else
	{
		alert(str_ErrSubirProductos);
	}
	
	jQuery("#btnMantenProductos").show();
	jQuery("#TXT_PRODUCTOS").show();
	
}




//	2ene17	recuperamos los datos de ofertas de un proveedor
function prepararEnvioMaestro(nombreFichero)
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
			//solodebug	console.log('prepararEnvioMaestroFichero: '+objeto);
			//solodebug	ficID=1;
			
			console.log('prepararEnvioMaestro ficID:'+data.PrepararEnvio.IDFichero);
			
			ficID=data.PrepararEnvio.IDFichero;
		}
	});
}


//	Enviamos todos los productos al servidor
function EnviarTodosMaestro(licNumRegistrosEnviados)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosMaestro INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

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

	var texto	=(licNumRegistrosEnviados+1)+'/'+ficProductos.length+': '+ficProductos[licNumRegistrosEnviados].NombreCli+'->'+ficProductos[licNumRegistrosEnviados].NombreMaest;
	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/EnviarMaestroAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumRegistrosEnviados
					+"&NOMBRECLIENTE="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].NombreCli)
					+"&NOMBREMAESTRO="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].NombreMaest)
					+"&FAMILIA="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].Familia)
					+"&SUBFAMILIA="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].Subfamilia)
					+"&MARCA="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].Marca)
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
				console.log('enviarLineaFichero [ERROR2]. ERROR ENVIANDO: ('+ficProductos[licNumRegistrosEnviados].NombreCli)+')';
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+ficProductos[licNumRegistrosEnviados].NombreCli+'):'+data.EnviarLinea.estado+'<br/>';
				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDLineaMO:'+data.EnviarLinea.idproducto+' -> '+ficProductos[licNumRegistrosEnviados].NombreCli);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			}

			//console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumRegistrosEnviados].Codigo+') '+ficProductos[licNumRegistrosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			EnviarTodosMaestro(licNumRegistrosEnviados);		

		}
	});
	
}


//	3mar17	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
function EnviarFicheroMaestro(ficProductos)
{
	var ficControlErrores='';
	var d= new Date();


	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero.';
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvioMaestro('Maestro_'+IDUsuario+'_'+d.getYear()+d.getMonth()+d.getDay()+d.getHours()+d.getMinutes()+d.getSeconds());

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
		EnviarTodosMaestro(0);
		
	}
	else
	{
		document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: ERROR:'+ficControlErrores;
	}

	return ficControlErrores;
}



//
//	Carga de fichero AsociarAMaestro
//


//	Funcion principal para recuperar, comprobar y enviar los productos
function AsociarAMaestroTXT()
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';

	//solodebug	var Control='';

	var Referencias	= oForm.elements['TXT_PRODUCTOS'].value;
	Referencias	= Referencias.replace(/[\t]/g, sepCampos);			// 	Tabulador para separar columnas en excel -> '|'

	ProcesarAsociarAMaestroTXT(Referencias)
};



//	Funcion principal para recuperar, comprobar y enviar los productos
function ProcesarAsociarAMaestroTXT(CadenaCambios)
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
		var IDMaestro='', RefMaestro='',Producto='', IDCliente='', RefCliente='';
		var Fila= Piece(CadenaCambios, '·',i);
		
		//solodebug	alert('['+Fila+']');

		col=0;
		IDMaestro	= Piece(Fila, sepCampos, col);
		++col;
		RefMaestro	= Piece(Fila, sepCampos, col);
		++col;
		Producto	= Piece(Fila, sepCampos, col);
		++col;
		IDCliente	= Piece(Fila, sepCampos, col);
		++col;
		RefCliente	= Piece(Fila, sepCampos, col);
		
		if (IDCliente=='') IDCliente=oForm.elements['FIDEMPRESA'].value;

		//solodebug		
		console.log('ProcesarAsociarAMaestroTXT. Linea ('+i+'). RefMaestro:'+RefMaestro+'. RefCliente:'+RefCliente+'. IDCliente:'+IDCliente+'. Producto:'+Producto);

		if ((RefCliente!='')||(IDMaestro!='')||(RefMaestro!=''))		//	Eliminamos líneas vacias
		{
			var items		= [];
			items['IDMaestro']	= IDMaestro;
			items['RefMaestro']	= RefMaestro;
			items['Producto'] = Producto;
			items['IDCliente'] = IDCliente;
			items['RefCliente'] = RefCliente;
			
			items['IDProducto'] = '';							//	inicializaremos vía ajax


			//	Comprobar campos obligatorios
			if (IDMaestro=='')
			{
				licAvisosCarga += '('+(i+1)+') '+(RefMaestro==''?RefCliente:RefMaestro)+': '+ strIDMaestroObligatorio+'<br/>';
			}

			if (RefMaestro=='')
			{
				licAvisosCarga += '('+(i+1)+') '+(RefCliente==''?Producto:RefCliente)+': '+ strReferenciaObligatoria+'<br/>';
			}

			if (RefCliente=='')
			{
				licAvisosCarga += '('+(i+1)+') '+(RefMaestro==''?Producto:RefMaestro)+': '+strReferenciaObligatoria +'<br/>';
			}

 			ficProductos.push(items);

			//solodebug
			console.log('Leyendo: RefCliente:'+RefCliente+'. RefMaestro:'+RefMaestro);

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
	
		jQuery('#infoProgreso').show();
		
		ficControlErrores=EnviarFicheroAsociarAMaestro(ficProductos);
	
	}
	else
	{
		alert(str_ErrSubirProductos);
	}
	
	jQuery("#btnMantenProductos").show();
	jQuery("#TXT_PRODUCTOS").show();
	
}




//	2ene17	recuperamos los datos de ofertas de un proveedor
function prepararEnvioAsociarAMaestro(nombreFichero)
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
			//solodebug	console.log('prepararEnvioAsociarAMaestroFichero: '+objeto);
			//solodebug	ficID=1;
			
			console.log('prepararEnvioAsociarAMaestro ficID:'+data.PrepararEnvio.IDFichero);
			
			ficID=data.PrepararEnvio.IDFichero;
		}
	});
}


//	Enviamos todos los productos al servidor
function EnviarTodosAsociarAMaestro(licNumRegistrosEnviados)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosAsociarAMaestro INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

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

	var texto	=(licNumRegistrosEnviados+1)+'/'+ficProductos.length+': '+ficProductos[licNumRegistrosEnviados].RefMaestro+'->'+ficProductos[licNumRegistrosEnviados].RefCliente;
	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/EnviarAsociarAMaestroAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumRegistrosEnviados
					+"&IDMAESTRO="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].IDMaestro)
					+"&REFMAESTRO="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefMaestro)
					+"&PRODUCTO="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].Producto)
					+"&IDCLIENTE="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].IDCliente)
					+"&REFCLIENTE="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefCliente)
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
				console.log('enviarLineaFichero [ERROR2]. ERROR ENVIANDO: ('+ficProductos[licNumRegistrosEnviados].RefMaestro)+')';
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+ficProductos[licNumRegistrosEnviados].RefMaestro+'->'+ficProductos[licNumRegistrosEnviados].IDCliente+':'+ficProductos[licNumRegistrosEnviados].RefCliente+'):'+data.EnviarLinea.estado+'<br/>';
				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDLineaMO:'+data.EnviarLinea.idproducto+' -> '+ficProductos[licNumRegistrosEnviados].IDCliente+':'+ficProductos[licNumRegistrosEnviados].NombreCli);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			}

			//console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumRegistrosEnviados].Codigo+') '+ficProductos[licNumRegistrosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			EnviarTodosAsociarAMaestro(licNumRegistrosEnviados);		

		}
	});
	
}


//	3mar17	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
function EnviarFicheroAsociarAMaestro(ficProductos)
{
	var ficControlErrores='';
	var d= new Date();


	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero.';
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvioAsociarAMaestro('AsociarAMaestro_'+IDUsuario+'_'+d.getYear()+d.getMonth()+d.getDay()+d.getHours()+d.getMinutes()+d.getSeconds());

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
		EnviarTodosAsociarAMaestro(0);
		
	}
	else
	{
		document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: ERROR:'+ficControlErrores;
	}

	return ficControlErrores;
}

//
//	Carga de fichero Contrato  -> INCLUIDO EN EL MANTENIMIENTO DEL MODELO DE CONTRATO
//

/*
//	Funcion principal para recuperar, comprobar y enviar los productos
function ContratoTXT()
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';

	//solodebug	var Control='';

	var Referencias	= oForm.elements['TXT_PRODUCTOS'].value;
	Referencias	= Referencias.replace(/[\t]/g, sepCampos);			// 	Tabulador para separar columnas en excel -> '|'

	ProcesarContratoTXT(Referencias);
}



//	Funcion principal para recuperar, comprobar y enviar los productos
function ProcesarContratoTXT(CadenaCambios)
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
		var LineaTexto;
		//var Producto= Piece(CadenaCambios, '·',i);
		//solodebug	alert('['+Producto+']');

		col=0;
		LineaTexto	= Piece(CadenaCambios, '·',i);
		++col;

		//solodebug		
		console.log('ProcesarContratoTXT. Linea ('+i+'). LineaTexto:'+LineaTexto);

		var items		= [];
		items['LineaTexto']	= LineaTexto;

		items['IDLinea'] = '';							//	inicializaremos vía ajax

 		ficProductos.push(items);

		//solodebug
		console.log('Leyendo: LineaTexto:'+LineaTexto);

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
	
		jQuery('#infoProgreso').show();
		
		ficControlErrores=EnviarFicheroContrato(ficProductos);
	
	}
	else
	{
		alert(str_ErrSubirProductos);
	}
	
	jQuery("#btnMantenProductos").show();
	jQuery("#TXT_PRODUCTOS").show();
	
}




//	2ene17	recuperamos los datos de ofertas de un proveedor
function prepararEnvioContrato(nombreFichero)
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
			//solodebug	console.log('prepararEnvioContratoFichero: '+objeto);
			//solodebug	ficID=1;
			
			console.log('prepararEnvioContrato ficID:'+data.PrepararEnvio.IDFichero);
			
			ficID=data.PrepararEnvio.IDFichero;
		}
	});
}


//	Enviamos todos los productos al servidor
function EnviarTodosContrato(licNumRegistrosEnviados)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosContrato INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

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

	var texto	=(licNumRegistrosEnviados+1)+'/'+ficProductos.length+': '+ficProductos[licNumRegistrosEnviados].LineaTexto;
	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/EnviarContratoAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumRegistrosEnviados
					+"&IDMODELO="+jQuery('#IDMODELOCONTRATO').val()
					+"&LINEATEXTO="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].LineaTexto)
					+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			ficError='ERROR_ENVIANDO';
			//licLineaError=numLineaInicio;
			
			ficControlErrores+=ficControlErrores+str_NoPodidoIncluirLinea;	//+': ('+ficProductos[licNumRegistrosEnviados].Referencia+') '+ficProductos[licNumRegistrosEnviados].Nombre+'<br/>';
			console.log('enviarLineaFichero [ERROR1]: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length+ ' => ERROR enviando:'+objeto+':'+quepaso+':'+otroobj);
			return 'ERROR';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			
			//
			//	Control de errores en la funcion que llama a esta
			//
						
			ficProductos[licNumRegistrosEnviados].IDLinea=data.EnviarLinea.idlinea;

			//	debug
			console.log('enviarLineaFichero: res:'||data.EnviarLinea.estado);
			
			//	Procesar error
			if (data.EnviarLinea.estado!='OK')
			{
				console.log('enviarLineaFichero [ERROR2]. ERROR ENVIANDO: ('+ficProductos[licNumRegistrosEnviados].LineaTexto)+')';
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+ficProductos[licNumRegistrosEnviados].LineaTexto+'):'+data.EnviarLinea.estado+'<br/>';
				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDLineaMO:'+data.EnviarLinea.idproducto+' -> '+ficProductos[licNumRegistrosEnviados].LineaTexto);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			}

			//console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumRegistrosEnviados].Codigo+') '+ficProductos[licNumRegistrosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			EnviarTodosContrato(licNumRegistrosEnviados);		

		}
	});
	
}


//	3mar17	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
function EnviarFicheroContrato(ficProductos)
{
	var ficControlErrores='';
	var d= new Date();


	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero.';
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvioContrato('Contrato_'+IDUsuario+'_'+d.getYear()+d.getMonth()+d.getDay()+d.getHours()+d.getMinutes()+d.getSeconds());

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
		EnviarTodosContrato(0);
		
	}
	else
	{
		document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: ERROR:'+ficControlErrores;
	}

	return ficControlErrores;
}
*/





//
//	Carga de fichero HistoricoPedidos
//


//	Funcion principal para recuperar, comprobar y enviar los productos
function HistoricoPedidosTXT()
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';

	//solodebug	var Control='';

	var Referencias	= oForm.elements['TXT_PRODUCTOS'].value;
	Referencias	= Referencias.replace(/[\t]/g, sepCampos);			// 	Tabulador para separar columnas en excel -> '|'

	ProcesarHistoricoPedidosTXT(Referencias);
}



//	Funcion principal para recuperar, comprobar y enviar los productos
function ProcesarHistoricoPedidosTXT(CadenaCambios)
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';
	
	jQuery("#TXT_PRODUCTOS").hide();
	jQuery("#btnMantenProductos").hide();
	jQuery('#infoErrores').html('');
	
	var IDCliente = oForm.elements['FIDEMPRESA'].value;

	//solodebug		
	debug('Fase 0\n\r'+CadenaCambios);

	CadenaCambios	= CadenaCambios.replace(/·/g, '');						//	Quitamos los caracteres que utilizaremos como separadores
	CadenaCambios	= CadenaCambios.replace(/(?:\r\n|\r|\n)/g, '·');
	
	var numRefs	= PieceCount(CadenaCambios, '·');
	
	//solodebug		
	debug('Fase 1\n\r'+CadenaCambios);
	
	ficProductos	= new Array();
	ficControlErrores ='';
	
	var IDCliente=oForm.elements['FIDEMPRESA'].value;
	
	for (i=0;i<=numRefs;++i)
	{
		var CodPedido='', CodLugarEntrega='', CodCentroCoste='', Proveedor='',NITProveedor='', CodComprador='', EstadoPedido='', RefCliente='', RefProveedor='', 
				Producto='', UdBasica='', UdesLote='', TipoIva='', Precio='', PrecioDiv='', 
				Divisa='', Cantidad='', CantidadPend='', ImportePend='', FechaEntrega='', FechaPedido='';
		var Fila= Piece(CadenaCambios, '·',i);
		
		//solodebug	alert('['+Fila+']');


		//////Numero OC	Proveedor	NIT	Comprador ID	Estado Orden	Codigo	Nombre SKU	Valor Unitario	Valor Unitario (Moneda)	DIVISA	Cantidad solicitada	Cantidad Remanente OC	Dinero Remanente (Moneda)	Fecha prevista entrega	Fecha OC

		col=0;
		CodPedido	= Piece(Fila, sepCampos, col);
		++col;
		CodLugarEntrega	= Piece(Fila, sepCampos, col);
		++col;
		CodCentroCoste	= Piece(Fila, sepCampos, col);
		++col;
		Proveedor	= Piece(Fila, sepCampos, col);
		++col;
		NifProveedor	= Piece(Fila, sepCampos, col);
		++col;
		CodComprador	= Piece(Fila, sepCampos, col);
		++col;
		EstadoPedido	= Piece(Fila, sepCampos, col);
		++col;
		RefCliente	= Piece(Fila, sepCampos, col);
		++col;
		RefProveedor	= Piece(Fila, sepCampos, col);
		++col;
		Producto	= Piece(Fila, sepCampos, col);
		++col;
		UdBasica	= Piece(Fila, sepCampos, col);
		++col;
		UdesLote	= Piece(Fila, sepCampos, col);
		++col;
		TipoIva	= Piece(Fila, sepCampos, col);
		++col;
		Precio	= Piece(Fila, sepCampos, col);
		++col;
		PrecioDiv	= Piece(Fila, sepCampos, col);
		++col;
		Divisa	= Piece(Fila, sepCampos, col);
		++col;
		Cantidad	= Piece(Fila, sepCampos, col);
		++col;
		CantidadPend	= Piece(Fila, sepCampos, col);
		++col;
		ImportePend	= Piece(Fila, sepCampos, col);
		++col;
		FechaEntrega	= Piece(Fila, sepCampos, col);
		++col;
		FechaPedido	= Piece(Fila, sepCampos, col);
		
		//solodebug		
		console.log('ProcesarHistoricoPedidosTXT. Linea ('+i+'). CodPedido:'+CodPedido+' NITProveedor:'+NITProveedor+'. RefCliente:'+RefCliente+'. IDCliente:'+IDCliente+'. Producto:'+Producto);

		if ((CodPedido!='Numero OC')&&(CodPedido!=''))		//	Eliminamos líneas vacias o titulo de fila
		{
			var items		= [];
			items['IDCliente'] = IDCliente;
			items['CodPedido']	= CodPedido;
			items['CodLugarEntrega']	= CodLugarEntrega;
			items['CodCentroCoste']	= CodCentroCoste;
			items['Proveedor']	= Proveedor;
			items['NifProveedor'] = NifProveedor;
			items['CodComprador'] = CodComprador;
			items['EstadoPedido'] = EstadoPedido;
			items['RefCliente'] = RefCliente;
			items['RefProveedor'] = RefProveedor;
			items['Producto'] = Producto;
			items['UdBasica'] = UdBasica;
			items['UdesLote'] = UdesLote;
			items['TipoIva'] = TipoIva;
			items['Precio'] = Precio;
			items['PrecioDiv'] = PrecioDiv;
			items['Divisa'] = Divisa;
			items['Cantidad'] = Cantidad;
			items['CantidadPend'] = CantidadPend;
			items['ImportePend'] = ImportePend;
			items['FechaEntrega'] = FechaEntrega;
			items['FechaPedido'] = FechaPedido;
			
			items['IDLineaPedido'] = '';							//	inicializaremos vía ajax


			//	Comprobar campos obligatorios
			if (CodPedido=='')
			{
				licAvisosCarga += '('+(i+1)+') '+strCampoObligatorio.replace('[[CAMPO]]',ncNumeroPedido)+'<br/>';
			}

			if (NifProveedor=='')
			{
				licAvisosCarga += '('+(i+1)+') '+CodPedido+': '+ strCampoObligatorio.replace('[[CAMPO]]',ncNifProveedor)+'<br/>';
			}

			if (CodComprador=='')
			{
				licAvisosCarga += '('+(i+1)+') '+CodPedido+': '+ strCampoObligatorio.replace('[[CAMPO]]',ncCodComprador)+'<br/>';
			}

			if (RefCliente=='')
			{
				licAvisosCarga += '('+(i+1)+') '+CodPedido+': '+ strCampoObligatorio.replace('[[CAMPO]]',ncRefCliente)+'<br/>';
			}

			if (RefProveedor=='')
			{
				licAvisosCarga += '('+(i+1)+') '+CodPedido+': '+ strCampoObligatorio.replace('[[CAMPO]]',ncRefProveedor)+'<br/>';
			}

			if (UdBasica=='')
			{
				licAvisosCarga += '('+(i+1)+') '+CodPedido+': '+ strCampoObligatorio.replace('[[CAMPO]]',ncUdBasica)+'<br/>';
			}

			if (UdesLote=='')
			{
				licAvisosCarga += '('+(i+1)+') '+CodPedido+': '+ strCampoObligatorio.replace('[[CAMPO]]',ncUdesLote)+'<br/>';
			}

			if (TipoIva=='')
			{
				licAvisosCarga += '('+(i+1)+') '+CodPedido+': '+ strCampoObligatorio.replace('[[CAMPO]]',ncIVA)+'<br/>';
			}

			if (Precio=='')
			{
				licAvisosCarga += '('+(i+1)+') '+CodPedido+': '+ strCampoObligatorio.replace('[[CAMPO]]',ncPrecio)+'<br/>';
			}

			if (Cantidad=='')
			{
				licAvisosCarga += '('+(i+1)+') '+CodPedido+': '+ strCampoObligatorio.replace('[[CAMPO]]',ncCantidad)+'<br/>';
			}

			if (CantidadPend=='')
			{
				licAvisosCarga += '('+(i+1)+') '+CodPedido+': '+ strCampoObligatorio.replace('[[CAMPO]]',ncCantidadPendiente)+'<br/>';
			}

			if (FechaEntrega=='')
			{
				licAvisosCarga += '('+(i+1)+') '+CodPedido+': '+ strCampoObligatorio.replace('[[CAMPO]]',ncFechaPrevistaEntrega)+'<br/>';
			}

			if (FechaPedido=='')
			{
				licAvisosCarga += '('+(i+1)+') '+CodPedido+': '+ strCampoObligatorio.replace('[[CAMPO]]',ncFechaPedido)+'<br/>';
			}
			
			//	Falta validar formato de fecha/hora

 			ficProductos.push(items);

			//solodebug
			console.log('Leyendo: CodPedido:'+CodPedido+'. NITProveedor:'+NITProveedor+'. RefCliente:'+RefCliente);

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
	
		jQuery('#infoProgreso').show();
		
		ficControlErrores=EnviarFicheroHistoricoPedidos(ficProductos);
	
	}
	else
	{
		alert(str_ErrSubirProductos);
	}
	
	jQuery("#btnMantenProductos").show();
	jQuery("#TXT_PRODUCTOS").show();
	
}




//	2ene17	recuperamos los datos de ofertas de un proveedor
function prepararEnvioHistoricoPedidos(nombreFichero)
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
			//solodebug	console.log('prepararEnvioHistoricoPedidosFichero: '+objeto);
			//solodebug	ficID=1;
			
			console.log('prepararEnvioHistoricoPedidos ficID:'+data.PrepararEnvio.IDFichero);
			
			ficID=data.PrepararEnvio.IDFichero;
		}
	});
}


//	25jul21 Cerramos el fichero de historico de pedidos
function cerrarFicheroHistPedidos(numLineas, estado)
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


//	Enviamos todos los productos al servidor
function EnviarTodosHistoricoPedidos(licNumRegistrosEnviados)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosHistoricoPedidos INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

	//	Entrada en el proceso
	
	//solodebug
	console.log('enviarLineaFichero: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length);

	if (licNumRegistrosEnviados>=ficProductos.length)
	{

		if (ficControlErrores==0)
		{
			//solodebug	
			console.log('enviarLineaFichero: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length + ' -> cerrarFichero sin errores');
			
			cerrarFicheroHistPedidos(licNumRegistrosEnviados, 'OK');
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
			cerrarFicheroHistPedidos(licNumRegistrosEnviados, 'ERROR');
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

	var texto	=(licNumRegistrosEnviados+1)+'/'+ficProductos.length+': '+ficProductos[licNumRegistrosEnviados].CodPedido+'. '+ficProductos[licNumRegistrosEnviados].RefCliente;
	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/EnviarHistoricoPedidosAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumRegistrosEnviados
					+"&IDCLIENTE="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].IDCliente)
					+"&CODPEDIDO="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].CodPedido)
					+"&CODLUGARENTREGA="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].CodLugarEntrega)
					+"&CODCENTROCOSTE="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].CodCentroCoste)
					+"&PROVEEDOR="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].Proveedor)
					+"&NIFPROVEEDOR="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].NifProveedor)
					+"&CODCOMPRADOR="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].CodComprador)
					+"&ESTADOPEDIDO="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].EstadoPedido)
					+"&REFCLIENTE="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefCliente)
					+"&REFPROVEEDOR="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefProveedor)
					+"&PRODUCTO="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].Producto)
					+"&UNIDADBASICA="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].UdBasica)
					+"&UNIDADESLOTE="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].UdesLote)
					+"&TIPOIVA="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].TipoIva)
					+"&PRECIO="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].Precio)
					+"&PRECIODIV="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].PrecioDiv)
					+"&DIVISA="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].Divisa)
					+"&CANTIDAD="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].Cantidad)
					+"&CANTIDADPEND="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].CantidadPend)
					+"&IMPORTEPEND="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].ImportePend)
					+"&FECHAENTREGA="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].FechaEntrega)
					+"&FECHAPEDIDO="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].FechaPedido)
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
						
			ficProductos[licNumRegistrosEnviados].IDLineaPedido=data.EnviarLinea.idlineapedido;

			//	debug
			console.log('enviarLineaFichero: res:'||data.EnviarLinea.estado);
			
			//	Procesar error
			if (data.EnviarLinea.estado!='OK')
			{
				console.log('enviarLineaFichero [ERROR2]. ERROR ENVIANDO: ('+ficProductos[licNumRegistrosEnviados].CodPedido)+')';
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+ficProductos[licNumRegistrosEnviados].CodPedido+'. '+ficProductos[licNumRegistrosEnviados].RefCliente+'):'+data.EnviarLinea.estado+'<br/>';
				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDLineaMO:'+data.EnviarLinea.idlineapedido+'. '+ficProductos[licNumRegistrosEnviados].RefCliente);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			}

			//console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumRegistrosEnviados].Codigo+') '+ficProductos[licNumRegistrosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			EnviarTodosHistoricoPedidos(licNumRegistrosEnviados);		

		}
	});
	
}


//	3mar17	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
function EnviarFicheroHistoricoPedidos(ficProductos)
{
	var ficControlErrores='';
	var d= new Date();


	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero.';
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvioHistoricoPedidos('HistoricoPedidos_'+IDUsuario+'_'+d.getYear()+d.getMonth()+d.getDay()+d.getHours()+d.getMinutes()+d.getSeconds());

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
		EnviarTodosHistoricoPedidos(0);
		
	}
	else
	{
		document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: ERROR:'+ficControlErrores;
	}

	return ficControlErrores;
}




//	9abr19 Esta función convendría incluirla en la librería general
function htmlDecode(input){
  var e = document.createElement('div');
  e.innerHTML = input;
  return e.childNodes.length === 0 ? "" : e.childNodes[0].nodeValue;
}





//
//	18ene22	Actualizar tarifas (catálogo de proveedores)
//


//	Funcion principal para recuperar, comprobar y enviar los productos
function ActualizarTarifasTXT()
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';
	
	var IDCliente = oForm.elements['FIDEMPRESA'].value;

	//solodebug	var Control='';

	var Referencias	= oForm.elements['TXT_PRODUCTOS'].value;
	Referencias	= Referencias.replace(/[\t]/g, sepCampos);			// 	Tabulador para separar columnas en excel -> '|'

	ProcesarActualizarTarifasTXT(Referencias);
}



//	Funcion principal para recuperar, comprobar y enviar los productos
function ProcesarActualizarTarifasTXT(CadenaCambios)
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
		var CodProveedor,Referencia,Precio,Nombre,FechaFinal;
		var Producto= Piece(CadenaCambios, '·',i);

		//solodebug	alert('['+Producto+']');
		
		col=0;
		CodProveedor = Piece(Producto, sepCampos, 0);
		++col;
		Referencia	= Piece(Producto, sepCampos, col);
		++col;
		Precio		= Piece(Producto, sepCampos, col);
		++col;
		Nombre		= Piece(Producto, sepCampos, col);
		++col;
		FechaFinal	= Piece(Producto, sepCampos, col);
		++col;
		CantBonif	= Piece(Producto, sepCampos, col);
		++col;
		CantGratis	= Piece(Producto, sepCampos, col);

		//solodebug		
		console.log('MantenProductosTXT. Linea ('+i+'). CodProveedor:'+CodProveedor+'. Ref:'+Referencia+'. Prod:'+Nombre+'. Precio:'+Precio+'. FechaFinal:'+FechaFinal+'. CantBonif:'+CantBonif+'. CantGratis:'+CantGratis);

		if ((Referencia!='RefProveedor')&&(Referencia!=''))		//	Eliminamos líneas vacias y linea de titulo. Cuidado, ponia &&(Nombre!='') pero este campo es opcional
		{
			var items		= [];
			items['IDCliente']	= IDCliente;
			items['CodProveedor']	= CodProveedor;
			items['Referencia']	= Referencia;
			items['Nombre'] = Nombre;
			items['Precio'] = Precio.replace(/\./g,"");			//	Eliminamos los puntos (separador de miles)
			items['FechaFinal'] = FechaFinal;					//	21abr22 Nuevo campo, fecha final de tarifa
			items['CantBonif'] = CantBonif;						//	01set22 Nuevo campo, cantidad bonificada
			items['CantGratis'] = CantGratis;					//	01set22 Nuevo campo, cantidad gratis
			items['IDProducto'] = '';							//	inicializaremos vía ajax


			//	Comprobar campos obligatorios
			//	Cod Proveedor
			if ((requiereProveedor=='S') && (CodProveedor==''))
			{
				//solodebug licAvisosCarga += 'conterr1';
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strCodProveedorObligatorio +'<br/>';
			}
			
			//	Referencia
			if (Referencia=='')
			{
				//solodebug licAvisosCarga += 'conterr2';
				licAvisosCarga += '('+(i+1)+') '+Nombre+': '+strReferenciaObligatoria +'<br/>';
			}
			
			//	Precio
			if (Precio=='')
			{
				//solodebug licAvisosCarga += 'conterr2';
				licAvisosCarga += '('+(i+1)+') '+Nombre+': '+strPrecioObligatorio +'<br/>';
			}

			//	Precio
			if ((items['Precio']!='')&&(isNaN(parseFloat(items['Precio']))))
			{
				//solodebug licAvisosCarga += 'conterr6';
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strPrecioNoNumerico +'<br/>';
			}

			//	CantBonif
			if ((items['CantBonif']!='')&&(isNaN(parseFloat(items['CantBonif']))))
			{
				//solodebug licAvisosCarga += 'conterr6';
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strCantBonifNoNumerico +'<br/>';
			}

			//	CantGratis
			if ((items['CantGratis']!='')&&(isNaN(parseFloat(items['CantGratis']))))
			{
				//solodebug licAvisosCarga += 'conterr6';
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strCantGratisNoNumerico +'<br/>';
			}

 			ficProductos.push(items);

			//solodebug
			console.log('MantenProductosTXT. Linea ('+i+'). INCLUIDA LINEA. IDCliente:'+IDCliente+ ' CodProveedor:'+CodProveedor+' Prod: ('+items['Referencia']+') '+items['Nombre']+'. Precio:'+items['Precio']);

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
		
		ficControlErrores=EnviarFicheroTarifas(ficProductos);
	
	}
	else
	{
		alert(str_ErrSubirProductos);
	}
	
	jQuery("#btnMantenProductos").show();
	jQuery("#TXT_PRODUCTOS").show();
	
}




//	2ene17	recuperamos los datos de ofertas de un proveedor
function prepararEnvioTarifas(nombreFichero)
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
			//solodebug	console.log('prepararEnvioCatProvFichero: '+objeto);
			//solodebug	ficID=1;
			
			console.log('prepararEnvioTarifas ficID:'+data.PrepararEnvio.IDFichero);
			
			ficID=data.PrepararEnvio.IDFichero;
		}
	});
}


//	Enviamos todos los productos al servidor
function EnviarTodosTarifas(licNumRegistrosEnviados, ForzarNombre)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosProductosCatProv INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

	//	Entrada en el proceso
	
	//solodebug
	console.log('EnviarTodosTarifas: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length);

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

	var texto	=(licNumRegistrosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumRegistrosEnviados].Referencia+'] '+ficProductos[licNumRegistrosEnviados].Nombre;

	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/MantenProductoAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumRegistrosEnviados
					+"&IDCLIENTE="+ficProductos[licNumRegistrosEnviados].IDCliente
					+"&CODNITPROVEEDOR="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].CodProveedor)
					+"&REFERENCIA="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].Referencia)
					+"&NOMBRE="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].Nombre))
					+"&PRECIO="+ficProductos[licNumRegistrosEnviados].Precio
					+"&OTROS=ACTUALIZAR_TARIFA|"+ficProductos[licNumRegistrosEnviados].FechaFinal+'|'+ficProductos[licNumRegistrosEnviados].CantBonif+'|'+ficProductos[licNumRegistrosEnviados].CantGratis
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
				console.log('enviarLineaFichero [ERROR2]. ERROR ENVIANDO: ('+ficProductos[licNumRegistrosEnviados].Referencia+') '+ficProductos[licNumRegistrosEnviados].Nombre);
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+ficProductos[licNumRegistrosEnviados].Referencia+') '+ficProductos[licNumRegistrosEnviados].Nombre+':'+data.EnviarLinea.estado+'<br/>';
				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDLineaMO:'+data.EnviarLinea.idproducto+' -> ('+ficProductos[licNumRegistrosEnviados].Referencia+') '+ficProductos[licNumRegistrosEnviados].Nombre);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			}

			//console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumRegistrosEnviados].Codigo+') '+ficProductos[licNumRegistrosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			EnviarTodosTarifas(licNumRegistrosEnviados, ForzarNombre);		

		}
	});
	
}


//	3mar17	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
function EnviarFicheroTarifas(ficProductos)
{
	var ficControlErrores='';
	var d= new Date();


	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero.';
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvioTarifas('MANTENPRODUCTOS_'+IDUsuario+'_'+d.getYear()+d.getMonth()+d.getDay()+d.getHours()+d.getMinutes()+d.getSeconds());

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
		
		if (jQuery('#chkForzar').is(':checked')) ForzarNombre='S';				//	30jun22 antes:.attr('checked')
		
		console.log('EnviarFicheroTarifas. ForzarNombre:'+ForzarNombre);
		
		//	Version recursiva
		EnviarTodosTarifas(0, ForzarNombre);
		
	}
	else
	{
		document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: ERROR:'+ficControlErrores;
	}

	return ficControlErrores;
}




//
//	Carga de fichero ResumenPedidos
//


//	Funcion principal para recuperar, comprobar y enviar los productos
function ResumenPedidosTXT()
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';

	//solodebug	var Control='';

	var Referencias	= oForm.elements['TXT_PRODUCTOS'].value;
	Referencias	= Referencias.replace(/[\t]/g, sepCampos);			// 	Tabulador para separar columnas en excel -> '|'

	ProcesarResumenPedidosTXT(Referencias);
}



//	Funcion principal para recuperar, comprobar y enviar los productos
function ProcesarResumenPedidosTXT(CadenaCambios)
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';
	
	jQuery("#TXT_PRODUCTOS").hide();
	jQuery("#btnMantenProductos").hide();
	jQuery('#infoErrores').html('');
	
	var IDCliente = oForm.elements['FIDEMPRESA'].value;

	//solodebug		
	debug('Fase 0\n\r'+CadenaCambios);

	CadenaCambios	= CadenaCambios.replace(/·/g, '');						//	Quitamos los caracteres que utilizaremos como separadores
	CadenaCambios	= CadenaCambios.replace(/(?:\r\n|\r|\n)/g, '·');
	
	var numRefs	= PieceCount(CadenaCambios, '·');
	
	//solodebug		
	debug('Fase 1\n\r'+CadenaCambios);
	
	ficProductos	= new Array();
	ficControlErrores ='';
	
	var IDCliente=oForm.elements['FIDEMPRESA'].value;
	
	for (i=0;i<=numRefs;++i)
	{
		var RefCliente='', Producto='', Cantidad='', FechaPedido='';
		var Fila= Piece(CadenaCambios, '·',i);
		
		//solodebug	alert('['+Fila+']');


		//////Numero OC	Proveedor	NIT	Comprador ID	Estado Orden	Codigo	Nombre SKU	Valor Unitario	Valor Unitario (Moneda)	DIVISA	Cantidad solicitada	Cantidad Remanente OC	Dinero Remanente (Moneda)	Fecha prevista entrega	Fecha OC

		col=0;
		FechaPedido	= Piece(Fila, sepCampos, col);
		++col;
		RefCliente	= Piece(Fila, sepCampos, col);
		++col;
		Producto	= Piece(Fila, sepCampos, col);
		++col;
		Cantidad	= Piece(Fila, sepCampos, col);
		
		//solodebug		
		console.log('ProcesarResumenPedidosTXT. Linea ('+i+'). IDCliente:'+IDCliente+'. FechaPedido:'+FechaPedido+'. RefCliente:'+RefCliente+'. Producto:'+Producto+'. Cantidad:'+Cantidad);

		if ((FechaPedido!='FECHA')&&(FechaPedido!=''))		//	Eliminamos líneas vacias o titulo de fila
		{
			var items		= [];
			items['IDCliente'] = IDCliente;
			items['RefCliente'] = RefCliente;
			items['Producto'] = Producto;
			items['Cantidad'] = Cantidad;
			items['FechaPedido'] = FechaPedido;
			
			items['IDLineaPedido'] = '';							//	inicializaremos vía ajax


			//	Comprobar campos obligatorios
			if (RefCliente=='')
			{
				licAvisosCarga += '('+(i+1)+') '+CodPedido+': '+ strCampoObligatorio.replace('[[CAMPO]]',ncRefCliente)+'<br/>';
			}
			if (Cantidad=='')
			{
				licAvisosCarga += '('+(i+1)+') '+CodPedido+': '+ strCampoObligatorio.replace('[[CAMPO]]',ncCantidad)+'<br/>';
			}
			if (FechaPedido=='')
			{
				licAvisosCarga += '('+(i+1)+') '+CodPedido+': '+ strCampoObligatorio.replace('[[CAMPO]]',ncFechaPedido)+'<br/>';
			}
			
			//	Falta validar formato de fecha/hora

 			ficProductos.push(items);

			//solodebug
			console.log('Leyendo: IDCliente:'+IDCliente+'. FechaPedido:'+FechaPedido+'. RefCliente:'+RefCliente+'. Producto:'+Producto+'. Cantidad:'+Cantidad);

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
	
		jQuery('#infoProgreso').show();
		
		ficControlErrores=EnviarFicheroResumenPedidos(ficProductos);
	
	}
	else
	{
		alert(str_ErrSubirProductos);
	}
	
	jQuery("#btnMantenProductos").show();
	jQuery("#TXT_PRODUCTOS").show();
	
}




//	2ene17	recuperamos los datos de ofertas de un proveedor
function prepararEnvioResumenPedidos(nombreFichero)
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
			//solodebug	console.log('prepararEnvioResumenPedidosFichero: '+objeto);
			//solodebug	ficID=1;
			
			console.log('prepararEnvioResumenPedidos ficID:'+data.PrepararEnvio.IDFichero);
			
			ficID=data.PrepararEnvio.IDFichero;
		}
	});
}


//	25jul21 Cerramos el fichero de historico de pedidos
function cerrarFicheroHistPedidos(numLineas, estado)
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


//	Enviamos todos los productos al servidor
function EnviarTodosResumenPedidos(licNumRegistrosEnviados)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosResumenPedidos INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

	//	Entrada en el proceso
	
	//solodebug
	console.log('enviarLineaFichero: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length);

	if (licNumRegistrosEnviados>=ficProductos.length)
	{

		if (ficControlErrores==0)
		{
			//solodebug	
			console.log('enviarLineaFichero: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length + ' -> cerrarFichero sin errores');
			
			cerrarFicheroHistPedidos(licNumRegistrosEnviados, 'OK');
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
			cerrarFicheroHistPedidos(licNumRegistrosEnviados, 'ERROR');
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

	var texto	=(licNumRegistrosEnviados+1)+'/'+ficProductos.length+': '+ficProductos[licNumRegistrosEnviados].FechaPedido+'. '+ficProductos[licNumRegistrosEnviados].RefCliente;
	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/EnviarResumenPedidosAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumRegistrosEnviados
					+"&IDCLIENTE="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].IDCliente)
					+"&REFCLIENTE="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].RefCliente)
					+"&PRODUCTO="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].Producto))
					+"&CANTIDAD="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].Cantidad)
					+"&FECHAPEDIDO="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].FechaPedido)
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
						
			ficProductos[licNumRegistrosEnviados].IDLineaPedido=data.EnviarLinea.idlineapedido;

			//	debug
			console.log('enviarLineaFichero: res:'||data.EnviarLinea.estado);
			
			//	Procesar error
			if (data.EnviarLinea.estado!='OK')
			{
				console.log('enviarLineaFichero [ERROR2]. ERROR ENVIANDO: ('+ficProductos[licNumRegistrosEnviados].CodPedido)+')';
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+ficProductos[licNumRegistrosEnviados].FechaPedido+'. '+ficProductos[licNumRegistrosEnviados].RefCliente+'):'+data.EnviarLinea.estado+'<br/>';
				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDLineaMO:'+data.EnviarLinea.idlineapedido+'. '+ficProductos[licNumRegistrosEnviados].RefCliente);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			}

			//console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumRegistrosEnviados].Codigo+') '+ficProductos[licNumRegistrosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			EnviarTodosResumenPedidos(licNumRegistrosEnviados);		

		}
	});
	
}


//	3mar17	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
function EnviarFicheroResumenPedidos(ficProductos)
{
	var ficControlErrores='';
	var d= new Date();


	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero.';
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvioResumenPedidos('ResumenPedidos_'+IDUsuario+'_'+d.getYear()+d.getMonth()+d.getDay()+d.getHours()+d.getMinutes()+d.getSeconds());

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
		EnviarTodosResumenPedidos(0);
		
	}
	else
	{
		document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: ERROR:'+ficControlErrores;
	}

	return ficControlErrores;
}



//
//	04jul22	Actualizar tipo de IVA (catálogo de proveedores)
//


//	Funcion principal para recuperar, comprobar y enviar los productos
function ActualizarTipoIvaTXT()
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';
	
	var IDCliente = oForm.elements['FIDEMPRESA'].value;

	//solodebug	var Control='';

	var Referencias	= oForm.elements['TXT_PRODUCTOS'].value;
	Referencias	= Referencias.replace(/[\t]/g, sepCampos);			// 	Tabulador para separar columnas en excel -> '|'

	ProcesarActualizarTipoIvaTXT(Referencias);
}



//	Funcion principal para recuperar, comprobar y enviar los productos
function ProcesarActualizarTipoIvaTXT(CadenaCambios)
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
		var CodProveedor,Referencia,Precio,Nombre,FechaFinal;
		var Producto= Piece(CadenaCambios, '·',i);

		//solodebug	alert('['+Producto+']');
		
		col=0;
		CodProveedor = Piece(Producto, sepCampos, 0);
		++col;
		Referencia	= Piece(Producto, sepCampos, col);
		++col;
		TipoIva		= Piece(Producto, sepCampos, col);
		++col;
		Nombre		= Piece(Producto, sepCampos, col);

		//solodebug		
		console.log('ProcesarActualizarTipoIvaTXT. Linea ('+i+'). CodProveedor:'+CodProveedor+'. Ref:'+Referencia+'. Prod:'+Nombre+'. TipoIva:'+TipoIva	);

		if ((Referencia!='')||(CodProveedor!=''))		//	Eliminamos líneas vacias
		{
			var items		= [];
			items['IDCliente']	= IDCliente;
			items['CodProveedor']	= CodProveedor;
			items['Referencia']	= Referencia;
			items['Nombre'] = Nombre;
			items['TipoIva'] = TipoIva;							
			items['IDProducto'] = '';							//	inicializaremos vía ajax


			//	Comprobar campos obligatorios
			//	Cod Proveedor
			if ((requiereProveedor=='S') && (CodProveedor==''))
			{
				//solodebug licAvisosCarga += 'conterr1';
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strCodProveedorObligatorio +'<br/>';
			}
			
			//	Referencia
			if (Referencia=='')
			{
				//solodebug licAvisosCarga += 'conterr2';
				licAvisosCarga += '('+(i+1)+') '+Nombre+': '+strReferenciaObligatoria +'<br/>';
			}
			
			//	TipoIva
			if (TipoIva=='')
			{
				//solodebug licAvisosCarga += 'conterr2';
				licAvisosCarga += '('+(i+1)+') '+Nombre+': '+strTipoIVAObligatorio +'<br/>';
			}

			//	TipoIva
			if ((TipoIva!='')&&(isNaN(parseInt(TipoIva))))
			{
				//solodebug licAvisosCarga += 'conterr6';
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strTipoIVAObligatorio +'<br/>';
			}

 			ficProductos.push(items);

			//solodebug
			console.log('ProcesarActualizarTipoIvaTXT. Linea ('+i+'). INCLUIDA LINEA. IDCliente:'+IDCliente+ ' CodProveedor:'+CodProveedor+' Prod: ('+items['Referencia']+') '+items['Nombre']+'. TipoIva:'+items['TipoIva']);

		}
		else
		{
			//solodebug
			console.log('Descartando línea en blanco:'+Producto);
		}


	}

	//solodebug	
	console.log('ProcesarActualizarTipoIvaTXT. :'+licAvisosCarga);

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
		
		ficControlErrores=EnviarFicheroTipoIva(ficProductos);
	
	}
	else
	{
		alert(str_ErrSubirProductos);
	}
	
	jQuery("#btnMantenProductos").show();
	jQuery("#TXT_PRODUCTOS").show();
	
}




//	2ene17	recuperamos los datos de ofertas de un proveedor
function prepararEnvioTipoIva(nombreFichero)
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
			//solodebug	console.log('prepararEnvioCatProvFichero: '+objeto);
			//solodebug	ficID=1;
			
			console.log('prepararEnvioTipoIva ficID:'+data.PrepararEnvio.IDFichero);
			
			ficID=data.PrepararEnvio.IDFichero;
		}
	});
}


//	Enviamos todos los productos al servidor
function EnviarTodosTipoIva(licNumRegistrosEnviados, ForzarNombre)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosProductosCatProv INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

	//	Entrada en el proceso
	
	//solodebug
	console.log('EnviarTodosTipoIva: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length);

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

	var texto	=(licNumRegistrosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumRegistrosEnviados].Referencia+'] '+ficProductos[licNumRegistrosEnviados].Nombre;
	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/MantenTipoIvaAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumRegistrosEnviados
					+"&IDCLIENTE="+ficProductos[licNumRegistrosEnviados].IDCliente
					+"&CODNITPROVEEDOR="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].CodProveedor)
					+"&REFERENCIA="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].Referencia)
					+"&NOMBRE="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].Nombre))
					+"&TIPOIVA="+ficProductos[licNumRegistrosEnviados].TipoIva
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
				console.log('enviarLineaFichero [ERROR2]. ERROR ENVIANDO: ('+ficProductos[licNumRegistrosEnviados].Referencia+') '+ficProductos[licNumRegistrosEnviados].Nombre);
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+ficProductos[licNumRegistrosEnviados].Referencia+') '+ficProductos[licNumRegistrosEnviados].Nombre+':'+data.EnviarLinea.estado+'<br/>';
				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDLineaMO:'+data.EnviarLinea.idproducto+' -> ('+ficProductos[licNumRegistrosEnviados].Referencia+') '+ficProductos[licNumRegistrosEnviados].Nombre);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			}

			//console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumRegistrosEnviados].Codigo+') '+ficProductos[licNumRegistrosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			EnviarTodosTipoIva(licNumRegistrosEnviados, ForzarNombre);		

		}
	});
	
}


//	3mar17	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
function EnviarFicheroTipoIva(ficProductos)
{
	var ficControlErrores='';
	var d= new Date();


	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero.';
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvioTipoIva('MANTENPRODUCTOS_'+IDUsuario+'_'+d.getYear()+d.getMonth()+d.getDay()+d.getHours()+d.getMinutes()+d.getSeconds());

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
		
		if (jQuery('#chkForzar').is(':checked')) ForzarNombre='S';				//	30jun22 antes:.attr('checked')
		
		console.log('EnviarFicheroTipoIva. ForzarNombre:'+ForzarNombre);
		
		//	Version recursiva
		EnviarTodosTipoIva(0, ForzarNombre);
		
	}
	else
	{
		document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: ERROR:'+ficControlErrores;
	}

	return ficControlErrores;
}



//
//	05set22	Actualizar centros de costes
//


//	Funcion principal para recuperar, comprobar y enviar los productos
function ActualizarCentrosCosteTXT()
{
	var oForm = document.forms['frmProductos'];
	var licAvisosCarga ='';
	
	var IDCliente = oForm.elements['FIDEMPRESA'].value;

	//solodebug	var Control='';

	var Referencias	= oForm.elements['TXT_PRODUCTOS'].value;
	Referencias	= Referencias.replace(/[\t]/g, sepCampos);			// 	Tabulador para separar columnas en excel -> '|'

	ProcesarActualizarCentrosCosteTXT(Referencias);
}



//	Funcion principal para recuperar, comprobar y enviar los productos
function ProcesarActualizarCentrosCosteTXT(CadenaCambios)
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
		var CodCentro, CodCentroCoste, NombreCentroCoste;
		var Producto= Piece(CadenaCambios, '·',i);

		//solodebug	alert('['+Producto+']');
		
		col=0;
		CodCentro	= Piece(Producto, sepCampos, col);
		++col;
		CodCentroCoste= Piece(Producto, sepCampos, col);
		++col;
		NombreCentroCoste= Piece(Producto, sepCampos, col);
		++col;
		PorDefecto= Piece(Producto, sepCampos, col).toString().toUpperCase();		//	Pasamos a mayusculas

		//solodebug		
		console.log('ProcesarActualizarCentrosCosteTXT. Linea ('+i+'). CodCentro:'+CodCentro+'. CodCentroCoste:'+CodCentroCoste+'. NombreCentroCoste:'+NombreCentroCoste+'. PorDefecto:'+PorDefecto);

		if ((CodCentro!='')||(CodCentroCoste!=''))		//	Eliminamos líneas vacias
		{
			var items		= [];
			items['IDCliente']	= IDCliente;
			items['CodCentro']	= CodCentro;
			items['CodCentroCoste']	= CodCentroCoste;
			items['NombreCentroCoste']	= NombreCentroCoste;
			items['PorDefecto']	= PorDefecto;

			//	Comprobar campos obligatorios			
			//	CentrosCoste
			if (NombreCentroCoste=='')
			{
				//solodebug licAvisosCarga += 'conterr2';
				licAvisosCarga += '('+(i+1)+') '+Nombre+': '+strCentrosCosteObligatorio +'<br/>';
			}

			if ((PorDefecto!='')&&(PorDefecto!='S')&&(PorDefecto!='N'))
			{
				//solodebug licAvisosCarga += 'conterr2';
				licAvisosCarga += '('+(i+1)+') '+Nombre+': '+strPorDefectoNoCorrecto +'<br/>';
			}
			else if (PorDefecto=='')
				items['PorDefecto']='N';

 			ficProductos.push(items);

			//solodebug
			console.log('ProcesarActualizarCentrosCosteTXT. Linea ('+i+'). INCLUIDA LINEA. IDCliente:'+IDCliente+ ' CodCentro:'+CodCentro+' CodCentroCoste: ('+items['CodCentroCoste']+') '+items['NombreCentroCoste']+'. def:'+items['PorDefecto']);

		}
		else
		{
			//solodebug
			console.log('Descartando línea en blanco:'+Producto);
		}


	}

	//solodebug	
	console.log('ProcesarActualizarCentrosCosteTXT. :'+licAvisosCarga);

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
		
		ficControlErrores=EnviarFicheroCentrosCoste(ficProductos);
	
	}
	else
	{
		alert(str_ErrSubirProductos);
	}
	
	jQuery("#btnMantenProductos").show();
	jQuery("#TXT_PRODUCTOS").show();
	
}




//	2ene17	recuperamos los datos de ofertas de un proveedor
function prepararEnvioCentrosCoste(nombreFichero)
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
			//solodebug	console.log('prepararEnvioCatProvFichero: '+objeto);
			//solodebug	ficID=1;
			
			console.log('prepararEnvioCentrosCoste ficID:'+data.PrepararEnvio.IDFichero);
			
			ficID=data.PrepararEnvio.IDFichero;
		}
	});
}


//	Enviamos todos los productos al servidor
function EnviarTodosCentrosCoste(licNumRegistrosEnviados)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosProductosCatProv INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&CentrosCoste="+CentrosCoste+"&TEXTO="+encodeURIComponent(texto));

	//	Entrada en el proceso
	
	//solodebug
	console.log('EnviarTodosCentrosCoste: licNumRegistrosEnviados:'+licNumRegistrosEnviados+ ' total:'+ficProductos.length);

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

	var texto	=(licNumRegistrosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumRegistrosEnviados].Referencia+'] '+ficProductos[licNumRegistrosEnviados].Nombre;
	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/CrearCentroCosteAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumRegistrosEnviados
					+"&IDCLIENTE="+ficProductos[licNumRegistrosEnviados].IDCliente
					+"&CODNITCENTRO="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].CodCentro)
					+"&CODCENTROCOSTE="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].CodCentroCoste)
					+"&CENTROCOSTE="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumRegistrosEnviados].NombreCentroCoste))
					+"&PORDEFECTO="+encodeURIComponent(ficProductos[licNumRegistrosEnviados].PorDefecto)
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
						
			//ficProductos[licNumRegistrosEnviados].IDProducto=data.EnviarLinea.idproducto;

			//	debug
			console.log('enviarLineaFichero: res:'||data.EnviarLinea.estado);
			
			//	Procesar error
			if (data.EnviarLinea.estado!='OK')
			{
				console.log('enviarLineaFichero [ERROR2]. ERROR ENVIANDO: ('+ficProductos[licNumRegistrosEnviados].CodCentroCoste+') '+ficProductos[licNumRegistrosEnviados].NombreCentroCoste);
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+ficProductos[licNumRegistrosEnviados].CodCentroCoste+') '+ficProductos[licNumRegistrosEnviados].NombreCentroCoste+':'+data.EnviarLinea.estado+'<br/>';
				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDLineaMO:'+data.EnviarLinea.idcentrocoste+' -> ('+ficProductos[licNumRegistrosEnviados].Referencia+') '+ficProductos[licNumRegistrosEnviados].Nombre);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			}

			//console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumRegistrosEnviados].Codigo+') '+ficProductos[licNumRegistrosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumRegistrosEnviados=licNumRegistrosEnviados+1;
			EnviarTodosCentrosCoste(licNumRegistrosEnviados);		

		}
	});
	
}


//	3mar17	Separamos la función para enviar licitaciones, así se podrá utilizar con diferentes formatos de ficheros de entrada
function EnviarFicheroCentrosCoste(ficProductos)
{
	var ficControlErrores='';
	var d= new Date();


	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero.';
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvioCentrosCoste('MANTENPRODUCTOS_'+IDUsuario+'_'+d.getYear()+d.getMonth()+d.getDay()+d.getHours()+d.getMinutes()+d.getSeconds());

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
		
		console.log('EnviarFicheroCentrosCoste.');
		
		//	Version recursiva
		EnviarTodosCentrosCoste(0);
		
	}
	else
	{
		document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: ERROR:'+ficControlErrores;
	}

	return ficControlErrores;
}




