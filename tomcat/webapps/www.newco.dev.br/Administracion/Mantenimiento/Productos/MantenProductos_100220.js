//	JS para el envio de mantenimiento de productos via ajax a la plataforma medicalvm.com
//	ultima revision ET 26nov19 12:00 MantenProductos_261119.js

var Dominio='http://www.newco.dev.br';	//	facilita portabilidad

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
		titulo+=']';
	}
	else if (opcion=='CATPROV')
	{
		jQuery("#Forzar").show();
		if (Rol=='COMPRADOR')
		{
			requiereProveedor='S';
			titulo=ncNifProveedor+sepCampos;
		}

		titulo+=ncRefProveedor+sepCampos+ncNombre+sepCampos+ncMarca+sepCampos+ncUdBasica+sepCampos+ncUdesLote+sepCampos+'['+ncPrecio+']';

		if (IDPais!=55)
		{
			requiereIVA='S';
			titulo+=sepCampos+'['+ncIVA+']';
		}

		if (IDPais==57)
		{
			requiereDatosAdicionalesCol='S';
			titulo+=sepCampos+ncCodExpediente+sepCampos+ncCodCum+sepCampos+ncInvima+sepCampos+ncFechaInvima+sepCampos+ncClasRiesgo;
		}
		
		titulo+='['+sepCampos+ncRefPack+sepCampos+ncCantidad+']]';
	}
	else if (opcion=='ADJUD')
	{
		jQuery("#Forzar").hide();
		titulo=ncRefEstandar+sepCampos+ncNifProveedor+sepCampos+ncRefProveedor+'['+sepCampos+ncOrden+']';

	}
	else if (opcion=='HOMOL')
	{
	
		jQuery("#Forzar").hide();
		titulo=ncNifCentro+sepCampos+ncRefCentro+sepCampos+ncRefCliente+'['+sepCampos+ncNifProveedor+sepCampos+ncRefProveedor+sepCampos+ncAutorizado+'['+sepCampos+ncOrden+'['+sepCampos+ncUnidadBasica+']'+']'+']';
	
	}
	else if (opcion=='PRECIOREF')
	{
	
		jQuery("#Forzar").hide();
		titulo=ncRefCliente+sepCampos+ncPrecioRef;
	
	}
	else if (opcion=='IDENTIF')
	{
		jQuery("#Forzar").hide();
		titulo=ncNifProveedor+sepCampos+ncRefProveedor+'['+sepCampos+ncPrecio+']'+'['+sepCampos+ncCantidad+']'+'['+sepCampos+ncNombre+']';

	}
	else if (opcion=='PROVEED')
	{
		jQuery("#Forzar").hide();
		
		//TUP_Nif,TUP_RefCliente,TUP_Nombre,TUP_NombreCorto,TUP_Direccion,TUP_Poblacion, TUP_Provincia,TUP_BARRIO,TUP_CodPostal,TUP_Telf,TUP_PlazoEntrNorm,TUP_PlazoEntrEmerg,
		//TUP_Categorias, TUP_TipoContacto,TUP_Titulo,TUP_Usuario,TUP_TelfUsuario,TUP_TelfUsuario2,TUP_Email,TUP_Cargo	
		titulo=ncNifProveedor+sepCampos+ncProveedor+sepCampos+ncNombreCorto+sepCampos+ncDireccion+sepCampos+ncPoblacion+sepCampos+ncProvincia
					+sepCampos+ncBarrio+sepCampos+ncCodPostal+sepCampos+ncTelefono+sepCampos+ncPlazoEntrNormal+sepCampos+ncPlazoEnvio
					+sepCampos+ncUsuario+sepCampos+ncTelfUsuario+sepCampos+ncEmailUsuario;
		
		ncRefProveedor+'['+sepCampos+ncPrecio+']'+'['+sepCampos+ncCantidad+']'+'['+sepCampos+ncNombre+']';
		
		jQuery("#trCliente").hide();
		
	}
		
		
		
	//solodebug	console.log('MostrarEstructuraDatos.'+opcion+':'+titulo);
	
	jQuery("#formatoCarga").html(titulo);
}



//	Funcion principal para recuperar, comprobar y enviar los productos
function MantenCatalogosTXT()
{
	var opcion = OpcionSeleccionada();
	
	console.log('MantenCatalogosTXT:'+opcion);
	
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
	else if (opcion=='PROVEED')
		ProveedoresTXT();
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
	console.log('ProcesarFichero '+fileName+':\n\r'+fileContent);

	var opcion = OpcionSeleccionada();
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
	else if (opcion=='PROVEED')
		ProcesarProveedoresTXT(fileContent);
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
function EnviarTodosClasificacion(licNumProductosEnviados, ForzarNombre)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosProductosProdEstandar INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

	//	Entrada en el proceso
	
	//solodebug
	console.log('EnviarTodosClasificacion: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length);

	if (licNumProductosEnviados>=ficProductos.length)
	{

		if (ficControlErrores==0)
		{
			//solodebug	
			console.log('EnviarTodosClasificacion: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length + ' -> cerrarFichero sin errores');
			
			cerrarFichero(licNumProductosEnviados, 'OK');
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
			console.log('EnviarTodosClasificacion: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length + ' -> cerrarFichero CON ERROR');
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

	var texto	=(licNumProductosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumProductosEnviados].RefGru+'] '+ficProductos[licNumProductosEnviados].Gru;
		
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/MantenClasificacionAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumProductosEnviados
					+"&IDCLIENTE="+ficProductos[licNumProductosEnviados].IDCliente
					+"&REFCAT="+encodeURIComponent(ficProductos[licNumProductosEnviados].RefCat)
					+"&REFCLICAT="+encodeURIComponent(ficProductos[licNumProductosEnviados].RefCliCat)
					+"&CAT="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Cat))
					+"&REFFAM="+encodeURIComponent(ficProductos[licNumProductosEnviados].RefFam)
					+"&REFCLIFAM="+encodeURIComponent(ficProductos[licNumProductosEnviados].RefCliFam)
					+"&FAM="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Fam))
					+"&REFSF="+encodeURIComponent(ficProductos[licNumProductosEnviados].RefSF)
					+"&REFCLISF="+encodeURIComponent(ficProductos[licNumProductosEnviados].RefCliSF)
					+"&SF="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].SF))
					+"&REFGRU="+encodeURIComponent(ficProductos[licNumProductosEnviados].RefGru)
					+"&REFCLIGRU="+encodeURIComponent(ficProductos[licNumProductosEnviados].RefCliGru)
					+"&GRU="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Gru))
					+"&REFPRO="+encodeURIComponent(ficProductos[licNumProductosEnviados].RefPro)
					+"&REFCLIPRO="+encodeURIComponent(ficProductos[licNumProductosEnviados].RefCliPro)
					+"&PRO="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Pro))
					+"&FORZARNOMBRE="+ForzarNombre,
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			ficError='ERROR_ENVIANDO';
			//licLineaError=numLineaInicio;
			
			ficControlErrores+=ficControlErrores+str_NoPodidoIncluirProducto;	//+': ('+ficProductos[licNumProductosEnviados].RefEstandar+') '+ficProductos[licNumProductosEnviados].Nombre+'<br/>';
			console.log('enviarProdEstandar [ERROR1]: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length+ ' => ERROR enviando:'+objeto+':'+quepaso+':'+otroobj);
			return 'ERROR';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			
			//
			//	Control de errores en la funcion que llama a esta
			//
						
			ficProductos[licNumProductosEnviados].IDProducto=data.EnviarLinea.idproducto;

			//	debug
			console.log('enviarProdEstandar: res:'||data.EnviarLinea.estado);
			
			//	Procesar error
			if (data.EnviarLinea.estado!='OK')
			{
				console.log('EnviarTodosClasificacion [ERROR2]. ERROR ENVIANDO: ('+licNumProductosEnviados+') '+ficProductos[licNumProductosEnviados].Cat);
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+licNumProductosEnviados+') '+ficProductos[licNumProductosEnviados].Cat+':'+data.EnviarLinea.estado+'<br/>';
				licNumProductosEnviados=licNumProductosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('EnviarTodosClasificacion: ENVIO CORRECTO. IDProdEstandar:'+data.EnviarLinea.idproducto+' -> ('+licNumProductosEnviados+') '+ficProductos[licNumProductosEnviados].Cat);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumProductosEnviados=licNumProductosEnviados+1;
			}

			//console.log('enviarProdEstandar: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumProductosEnviados].RefCat+') '+ficProductos[licNumProductosEnviados].Cat);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumProductosEnviados=licNumProductosEnviados+1;
			EnviarTodosClasificacion(licNumProductosEnviados, ForzarNombre);		

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
		
		if (jQuery('#chkForzar').attr('checked')) ForzarNombre='S';
		
		console.log('EnviarFicheroProdEstandar. ForzarNombre:'+ForzarNombre);
	
		
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

	ProcesarProdEstandarTXT(Referencias)
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
		var RefEstandar, RefCliente, Nombre, Marcas, PrecioRef, TipoIVA=0, Regulado='N', CurvaABC='', Orden='1', Registro='', FechaCadRegistro='', Oncologico='N';
		var Producto= Piece(CadenaCambios, '·',i);

		//solodebug	alert('['+Producto+']');
		
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
		//solodebug		
		console.log('MantenProductosTXT. Linea ('+i+'). RefEstandar:'+RefEstandar+'. Prod:'+Nombre+'. Marcas:'+Marcas
			+'. UdBasica:'+UdBasica+'. PrecioRef:'+PrecioRef+'. TipoIVA:'+TipoIVA+'. Regulado:'+Regulado+'. CurvaABC:'+CurvaABC
			+'. Registro:'+Registro+'. FechaCadRegistro:'+FechaCadRegistro+'. Oncologico:'+Oncologico);

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
function EnviarTodosProductosProdEstandar(licNumProductosEnviados, ForzarNombre)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosProductosProdEstandar INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

	//	Entrada en el proceso
	
	//solodebug
	console.log('enviarProdEstandar: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length);

	if (licNumProductosEnviados>=ficProductos.length)
	{

		if (ficControlErrores==0)
		{
			//solodebug	
			console.log('enviarProdEstandar: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length + ' -> cerrarFichero sin errores');
			
			cerrarFichero(licNumProductosEnviados, 'OK');
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
			console.log('enviarProdEstandar: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length + ' -> cerrarFichero CON ERROR');
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

	var texto	=(licNumProductosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumProductosEnviados].Referencia+'] '+ficProductos[licNumProductosEnviados].Nombre;
	
	var otros =//PENDIENTE'CONSUMO:'+ficProductos[licNumProductosEnviados].Consumo+
				'REG:'+ficProductos[licNumProductosEnviados].Regulado+'|ORDEN:'+ficProductos[licNumProductosEnviados].Orden+'|CURVA:'+ficProductos[licNumProductosEnviados].CurvaABC
				+'|REGISTRO:'+ficProductos[licNumProductosEnviados].Registro+'|FECHACAD:'+ficProductos[licNumProductosEnviados].FechaCadRegistro+'|ONCO:'+ficProductos[licNumProductosEnviados].Oncologico
				;

	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/MantenProdEstandarAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumProductosEnviados
					+"&IDCLIENTE="+ficProductos[licNumProductosEnviados].IDCliente
					+"&REFESTANDAR="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].RefEstandar))
					+"&REFCLIENTE="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].RefCliente))
					+"&NOMBRE="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Nombre))
					+"&MARCAS="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Marcas))
					+"&UDBASICA="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].UdBasica))
					+"&PRECIOREF="+ficProductos[licNumProductosEnviados].PrecioRef
					+"&TIPOIVA="+ficProductos[licNumProductosEnviados].TipoIVA
					+"&OTROS="+encodeURIComponent(ScapeHTMLString(otros))
					+"&FORZARNOMBRE="+ForzarNombre,
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			ficError='ERROR_ENVIANDO';
			//licLineaError=numLineaInicio;
			
			ficControlErrores+=ficControlErrores+str_NoPodidoIncluirProducto;	//+': ('+ficProductos[licNumProductosEnviados].RefEstandar+') '+ficProductos[licNumProductosEnviados].Nombre+'<br/>';
			console.log('enviarProdEstandar [ERROR1]: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length+ ' => ERROR enviando:'+objeto+':'+quepaso+':'+otroobj);
			return 'ERROR';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			
			//
			//	Control de errores en la funcion que llama a esta
			//
						
			ficProductos[licNumProductosEnviados].IDProducto=data.EnviarLinea.idproducto;

			//	debug
			console.log('enviarProdEstandar: res:'||data.EnviarLinea.estado);
			
			//	Procesar error
			if (data.EnviarLinea.estado!='OK')
			{
				console.log('enviarProdEstandar [ERROR2]. ERROR ENVIANDO: ('+ficProductos[licNumProductosEnviados].RefEstandar+') '+ficProductos[licNumProductosEnviados].Nombre);
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+ficProductos[licNumProductosEnviados].RefEstandar+') '+ficProductos[licNumProductosEnviados].Nombre+':'+data.EnviarLinea.estado+'<br/>';
				licNumProductosEnviados=licNumProductosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarProdEstandar: ENVIO CORRECTO. IDProdEstandar:'+data.EnviarLinea.idproducto+' -> ('+ficProductos[licNumProductosEnviados].RefEstandar+') '+ficProductos[licNumProductosEnviados].Nombre);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumProductosEnviados=licNumProductosEnviados+1;
			}

			//console.log('enviarProdEstandar: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumProductosEnviados].RefEstandar+') '+ficProductos[licNumProductosEnviados].Nombre);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumProductosEnviados=licNumProductosEnviados+1;
			EnviarTodosProductosProdEstandar(licNumProductosEnviados, ForzarNombre);		

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
		
		if (jQuery('#chkForzar').attr('checked')) ForzarNombre='S';
		
		console.log('EnviarFicheroProdEstandar. ForzarNombre:'+ForzarNombre);
	
		
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

	ProcesarCatProveedoresTXT(Referencias)
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
		var CodProveedor,Referencia,Nombre,Marca,UdBasica,UdesLote,Precio, TipoIVA=0, RefPack, Cantidad, CodExpediente='', CodCUM='', CodInvima='', FechaInvima='', ClasRiesgo='';
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


		//solodebug		
		console.log('MantenProductosTXT. Linea ('+i+'). CodProveedor:'+CodProveedor+'. Ref:'+Referencia+'. Prod:'+Nombre
			+'. UdBasica:'+UdBasica+'. UdesLote:'+UdesLote+'. Precio:'+Precio+'. TipoIVA:'+TipoIVA+'. CodInvima:'+CodInvima+'. RefPack:'+RefPack);

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
			items['CodCUM'] = CodCUM;
			items['CodInvima'] = CodInvima;
			items['FechaInvima'] = FechaInvima;
			items['ClasRiesgo'] = ClasRiesgo;

			items['RefPack'] = RefPack;
			items['Cantidad'] = Cantidad;
			
			items['IDProducto'] = '';							//	inicializaremos vía ajax


			//	Comprobar campos obligatorios
			//	Cod Proveedor
			if ((requiereProveedor=='S') && (CodProveedor==''))
			{
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strCodProveedorObligatorio +'<br/>';
			}
			
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
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strUdesLoteNoNumerico +'<br/>';
			}

			//	Precio
			if ((items['Precio']!='')&&(isNaN(parseFloat(items['Precio']))))
			{
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strPrecioNoNumerico +'<br/>';
			}

			//	TipoIVA
			if ((requiereIVA=='S') && (items['TipoIVA']!='')&&(isNaN(parseFloat(items['TipoIVA']))))
			{
				licAvisosCarga += '('+(i+1)+') '+Referencia+': AQUI '+strTipoIVAObligatorio +' ['+items['TipoIVA']+']<br/>';
			}

			//	Cantidad obligatoria si está ref pack informada
			console.log('Control pack. RefPack:'+RefPack+' Cant:'+items['Cantidad']);
			if ((RefPack!='') &&(isNaN(parseFloat(items['Cantidad']))))
			{
				console.log('Control pack. RefPack:'+RefPack+' Cant:'+items['Cantidad']+'. ERROR');
				licAvisosCarga += '('+(i+1)+') '+Referencia+': '+strCantidadObligatoria +'<br/>';
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
			console.log('Leyendo IDCliente:'+IDCliente+ ' CodProveedor:'+CodProveedor+' Prod: ('+items['Referencia']+') '+items['Nombre']+'. Precio:'+items['Precio']);

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

	var texto	=(licNumProductosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumProductosEnviados].Referencia+'] '+ficProductos[licNumProductosEnviados].Nombre;

	var Otros=ficProductos[licNumProductosEnviados].CodExpediente+'|'
				+ficProductos[licNumProductosEnviados].CodCUM+'|'
				+ficProductos[licNumProductosEnviados].CodInvima+'|'
				+ficProductos[licNumProductosEnviados].FechaInvima+'|'
				+ficProductos[licNumProductosEnviados].ClasRiesgo;
	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/MantenProductoAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumProductosEnviados
					+"&IDCLIENTE="+ficProductos[licNumProductosEnviados].IDCliente
					+"&CODNITPROVEEDOR="+encodeURIComponent(ficProductos[licNumProductosEnviados].CodProveedor)
					+"&REFERENCIA="+encodeURIComponent(ficProductos[licNumProductosEnviados].Referencia)
					+"&NOMBRE="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Nombre))
					+"&MARCA="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Marca))
					+"&UDBASICA="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].UdBasica))
					+"&UDESLOTE="+ficProductos[licNumProductosEnviados].UdesLote
					+"&PRECIO="+ficProductos[licNumProductosEnviados].Precio
					+"&TIPOIVA="+ficProductos[licNumProductosEnviados].TipoIVA
					+"&OTROS="+encodeURIComponent(ScapeHTMLString(Otros))		
					+"&REFPACK="+ficProductos[licNumProductosEnviados].RefPack
					+"&CANTIDAD="+ficProductos[licNumProductosEnviados].Cantidad
					+"&FORZARNOMBRE="+ForzarNombre+"&_="+d.getTime(),
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

	ProcesarAdjudicacionTXT(Referencias)
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
function EnviarTodosAdjudicacion(licNumProductosEnviados)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosAdjudicacion INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

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

	var texto	=(licNumProductosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumProductosEnviados].RefCliente+'] '+ficProductos[licNumProductosEnviados].CodProveedor+':'+ficProductos[licNumProductosEnviados].v;
	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/AdjudicacionAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumProductosEnviados
					+"&IDCLIENTE="+ficProductos[licNumProductosEnviados].IDCliente
					+"&REFCLIENTE="+encodeURIComponent(ficProductos[licNumProductosEnviados].RefCliente)
					+"&CODNITPROVEEDOR="+encodeURIComponent(ficProductos[licNumProductosEnviados].CodProveedor)
					+"&REFPROVEEDOR="+encodeURIComponent(ficProductos[licNumProductosEnviados].RefProveedor)
					+"&ORDEN="+encodeURIComponent(ficProductos[licNumProductosEnviados].Orden)
					+"&_="+d.getTime(),
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
				console.log('enviarLineaFichero [ERROR2]. ERROR ENVIANDO: ('+ficProductos[licNumProductosEnviados].RefCliente);
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+ficProductos[licNumProductosEnviados].RefCliente+'):'+data.EnviarLinea.estado+'<br/>';
				licNumProductosEnviados=licNumProductosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDLineaMO:'+data.EnviarLinea.idproducto+' -> '+ficProductos[licNumProductosEnviados].Referencia);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumProductosEnviados=licNumProductosEnviados+1;
			}

			//console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumProductosEnviados].Codigo+') '+ficProductos[licNumProductosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumProductosEnviados=licNumProductosEnviados+1;
			EnviarTodosAdjudicacion(licNumProductosEnviados);		

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

	ProcesarHomologacionTXT(Referencias)
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
		var CodCentro,RefCentro,RefCliente,CodProveedor,RefProveedor,Orden,UdBasica;
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

		//solodebug		
		console.log('ProcesarHomologacionTXT. Linea ('+i+'). RefCliente:'+RefCliente+'. CodProveedor:'+CodProveedor+'. RefProveedor:'+RefProveedor+'. Autorizado:'+Autorizado+'. Orden:'+Orden+'. UdBasica:'+UdBasica);

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
function EnviarTodosHomologacion(licNumProductosEnviados)
{
	var d= new Date();
	
	//solodebug	alert("EnviarTodosHomologacion INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

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

	var texto	=(licNumProductosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumProductosEnviados].RefCliente+':'+ficProductos[licNumProductosEnviados].RefCentro+'] '
			+((ficProductos[licNumProductosEnviados].CodProveedor=='')?'':ficProductos[licNumProductosEnviados].CodProveedor+':'+ficProductos[licNumProductosEnviados].RefProveedor);
	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/HomologacionAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumProductosEnviados
					+"&IDCLIENTE="+ficProductos[licNumProductosEnviados].IDCliente
					+"&CODCENTRO="+encodeURIComponent(ficProductos[licNumProductosEnviados].CodCentro)
					+"&REFCENTRO="+encodeURIComponent(ficProductos[licNumProductosEnviados].RefCentro)
					+"&REFCLIENTE="+encodeURIComponent(ficProductos[licNumProductosEnviados].RefCliente)
					+"&CODNITPROVEEDOR="+encodeURIComponent(ficProductos[licNumProductosEnviados].CodProveedor)
					+"&REFPROVEEDOR="+encodeURIComponent(ficProductos[licNumProductosEnviados].RefProveedor)
					+"&AUTORIZADO="+encodeURIComponent(ficProductos[licNumProductosEnviados].Autorizado)
					+"&ORDEN="+encodeURIComponent(ficProductos[licNumProductosEnviados].Orden)
					+"&UDBASICA="+encodeURIComponent(ficProductos[licNumProductosEnviados].UdBasica)
					+"&_="+d.getTime(),
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
				console.log('enviarLineaFichero [ERROR2]. ERROR ENVIANDO:'+texto);
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+ficProductos[licNumProductosEnviados].RefCentro+'):'+data.EnviarLinea.estado+'<br/>';
				licNumProductosEnviados=licNumProductosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDLineaMO:'+data.EnviarLinea.idproducto+' -> '+texto);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumProductosEnviados=licNumProductosEnviados+1;
			}

			//console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumProductosEnviados].Codigo+') '+ficProductos[licNumProductosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumProductosEnviados=licNumProductosEnviados+1;
			EnviarTodosHomologacion(licNumProductosEnviados);		

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

	ProcesarPreciosReferenciaTXT(Referencias)
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

			//	Cod Proveedor
			if (PrecioRef=='')
			{
				licAvisosCarga += '('+(i+1)+') '+RefCliente+': '+strPrecioObligatorio +'<br/>';	//10feb20
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
function EnviarTodosPreciosReferencia(licNumProductosEnviados)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosPreciosReferencia INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

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

	var texto	=(licNumProductosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumProductosEnviados].RefCliente+'] '+ficProductos[licNumProductosEnviados].CodProveedor+':'+ficProductos[licNumProductosEnviados].v;
	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/PreciosReferenciaAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumProductosEnviados
					+"&IDCLIENTE="+ficProductos[licNumProductosEnviados].IDCliente
					+"&REFCLIENTE="+encodeURIComponent(ficProductos[licNumProductosEnviados].RefCliente)
					+"&PRECIOREF="+encodeURIComponent(ficProductos[licNumProductosEnviados].PrecioRef)
					+"&_="+d.getTime(),
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
				console.log('enviarLineaFichero [ERROR2]. ERROR ENVIANDO: ('+ficProductos[licNumProductosEnviados].RefCliente)+')';
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+ficProductos[licNumProductosEnviados].RefCliente+'):'+data.EnviarLinea.estado+'<br/>';
				licNumProductosEnviados=licNumProductosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDLineaMO:'+data.EnviarLinea.idproducto+' -> '+ficProductos[licNumProductosEnviados].Referencia);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumProductosEnviados=licNumProductosEnviados+1;
			}

			//console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumProductosEnviados].Codigo+') '+ficProductos[licNumProductosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumProductosEnviados=licNumProductosEnviados+1;
			EnviarTodosPreciosReferencia(licNumProductosEnviados);		

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

	ProcesarIdentificarProductosTXT(Referencias)
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
function EnviarTodosIdentificarProductos(licNumProductosEnviados)
{
	var d		= new Date();
	
	//solodebug	alert("EnviarTodosPreciosReferencia INTF_ID="+ficID+"&NUMLINEA="+numLineaInicio+"&REFCLIENTE="+RefCliente+"&CANTIDAD="+Cantidad+"&TIPOIVA="+TipoIVA+"&TEXTO="+encodeURIComponent(texto));

	//	Entrada en el proceso
	
	//solodebug
	console.log('enviarLineaFichero: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length);

	if (licNumProductosEnviados>=ficProductos.length)
	{
	
		//	Con error o no, muestra el resultado de la exportación
		//	Cabecera para el fichero
		var contenidoCSV='"'+ncNifProveedor+'","'+ncRefProveedor+'","'+ncNombre+'","'+ncRefEstandar+'","'+ncRefCliente+'","'+ncNombreEstandar+'","'
				+ncPrecioCliente+'","'+ncPrecioCentral+'","'+ncCantidad+'","'+ncAhorro+'","'+ncAhorroPorc+'","'+ncOrigen+'"\n';
		
		var TotalCliente=0, TotalCentral=0, TotalAhorro=0, PorcAhorro;
		for (i=0;i<licNumProductosEnviados;++i)
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
			console.log('enviarLineaFichero: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length + ' -> cerrarFichero sin errores');
			
			cerrarFichero(licNumProductosEnviados, 'OK');
			jQuery('#infoProgreso').html(str_FicheroProcesado);
			jQuery('#infoProgreso').show();
			jQuery('#infoErrores').hide();
			
			ficID='';		//	Para poder reenviar la carga
			
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

	var texto	=(licNumProductosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumProductosEnviados].NIFProveedor+'] '+ficProductos[licNumProductosEnviados].RefProveedor+' '+ficProductos[licNumProductosEnviados].Nombre;
	jQuery('#infoProgreso').html(texto);

	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/IdentificarProductoAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumProductosEnviados
					+"&IDCLIENTE="+ficProductos[licNumProductosEnviados].IDCliente
					+"&NIFPROVEEDOR="+encodeURIComponent(ficProductos[licNumProductosEnviados].NIFProveedor)
					+"&REFPROVEEDOR="+encodeURIComponent(ficProductos[licNumProductosEnviados].RefProveedor)
					+"&PRECIO="+encodeURIComponent(ficProductos[licNumProductosEnviados].Precio)
					+"&CANTIDAD="+encodeURIComponent(ficProductos[licNumProductosEnviados].Cantidad)
					+"&PRODUCTO="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Nombre))
					+"&_="+d.getTime(),
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
			
			//texto:
			//	Control de errores en la funcion que llama a esta
			//
						
			ficProductos[licNumProductosEnviados].ProdEstandar=data.EnviarLinea.datosProducto;

			//	debug
			console.log('enviarLineaFichero: res:'||data.EnviarLinea.estado);
			
			//	Procesar error
			if (data.EnviarLinea.estado!='OK')
			{
				console.log('enviarLineaFichero [ERROR2]. ERROR ENVIANDO: ('+ficProductos[licNumProductosEnviados].RefProveedor)+')';
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='['+ficProductos[licNumProductosEnviados].NIFProveedor+'] '+ficProductos[licNumProductosEnviados].RefProveedor+':'+data.EnviarLinea.estado+'<br/>';
				licNumProductosEnviados=licNumProductosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDLineaMO:'+data.EnviarLinea.datosProducto+' -> '+ficProductos[licNumProductosEnviados].RefProveedor+' texto:'+texto);

				//jQuery('#infoProgreso').html(texto);

				//sIDCLIENTEolodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumProductosEnviados=licNumProductosEnviados+1;
			}

			//console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumProductosEnviados].Codigo+') '+ficProductos[licNumProductosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumProductosEnviados=licNumProductosEnviados+1;
			EnviarTodosIdentificarProductos(licNumProductosEnviados);		

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

	ProcesarProveedoresTXT(Referencias)
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
function EnviarTodosProveedores(licNumProductosEnviados)
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

	var texto	=(licNumProductosEnviados+1)+'/'+ficProductos.length+': ['+ficProductos[licNumProductosEnviados].NifProveedor+'] '+ficProductos[licNumProductosEnviados].Nombre;

	
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/CrearProveedorAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumProductosEnviados
					+"&NIFPROVEEDOR="+encodeURIComponent(ficProductos[licNumProductosEnviados].NifProveedor)
					+"&NOMBRE="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Proveedor))
					+"&NOMBRECORTO="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].NombreCorto))
					+"&DIRECCION="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Direccion))
					+"&POBLACION="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Poblacion))
					+"&PROVINCIA="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Provincia))
					+"&BARRIO="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Barrio))
					+"&CODPOSTAL="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].CodPostal))
					+"&TELEFONO="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Telf))
					+"&PLAZOENVIO="+ficProductos[licNumProductosEnviados].PlazoEnvio
					+"&PLAZOENTREGA="+ficProductos[licNumProductosEnviados].PlazoEntrega
					+"&USUARIO="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Usuario))
					+"&TELUSUARIO="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].TelUsuario))
					+"&EMAIL="+encodeURIComponent(ScapeHTMLString(ficProductos[licNumProductosEnviados].Email))
					+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			ficError='ERROR_ENVIANDO';
			//licLineaError=numLineaInicio;
			
			ficControlErrores+=ficControlErrores+str_NoPodidoIncluirProducto;
			console.log('enviarLineaFichero [ERROR1]: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length+ ' => ERROR enviando:'+objeto+':'+quepaso+':'+otroobj);
			return 'ERROR';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			
			//
			//	Control de errores en la funcion que llama a esta
			//
						
			ficProductos[licNumProductosEnviados].IDEmpresa=data.EnviarLinea.idempresa;

			//	debug
			console.log('enviarLineaFichero: res:'||data.EnviarLinea.estado);
			
			//	Procesar error
			if (data.EnviarLinea.estado!='OK')
			{
				console.log('enviarLineaFichero [ERROR2]. ERROR ENVIANDO: ('+ficProductos[licNumProductosEnviados].NifProveedor+') '+ficProductos[licNumProductosEnviados].Proveedor);
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+ficProductos[licNumProductosEnviados].NifProveedor+') '+ficProductos[licNumProductosEnviados].Proveedor+':'+data.EnviarLinea.estado+'<br/>';
				licNumProductosEnviados=licNumProductosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('enviarLineaFichero: ENVIO CORRECTO. IDLineaMO:'+data.EnviarLinea.idempresa+' -> ('+ficProductos[licNumProductosEnviados].NifProveedor+') '+ficProductos[licNumProductosEnviados].Proveedor);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumProductosEnviados=licNumProductosEnviados+1;
			}

			//console.log('enviarLineaFichero: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumProductosEnviados].Codigo+') '+ficProductos[licNumProductosEnviados].Descripcion);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumProductosEnviados=licNumProductosEnviados+1;
			EnviarTodosProveedores(licNumProductosEnviados);		

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






//	9abr19 Esta función convendría incluirla en la librería general
function htmlDecode(input){
  var e = document.createElement('div');
  e.innerHTML = input;
  return e.childNodes.length === 0 ? "" : e.childNodes[0].nodeValue;
}
