//	JS para manten. Modelo Modelo
//	Ultima revisión: ET 5set18 11:47

var Dominio='http://www.newco.dev.br';
var ficControlErrores='';

//	Activar Parsley
jQuery(function () {
  jQuery('#Modelo').parsley().on('field:validated', function() {
    var ok = jQuery('.parsley-error').length === 0;
    jQuery('.bs-callout-info').toggleClass('hidden', !ok);
    jQuery('.bs-callout-warning').toggleClass('hidden', ok);
  })
  .on('form:submit', function() {
	console.log("submit");
  });
});


//	Validar y enviar ficha básica
function ValidarYEnviar()
{
	jQuery('#Modelo').parsley().validate();

    var ok = jQuery('.parsley-error').length === 0;

	//console.log("Provincia:"+document.forms['frmFicha'].elements['PROVINCIA'].value);
	//
	console.log("ValidarYEnviar: IDForm:Modelo. val:"+ok);

	if (ok) 
	{
    	jQuery('.bs-callout-info').show();
    	jQuery('.bs-callout-warning').hide();
		
		document.forms['Modelo'].elements['ACCION'].value='GUARDAR';	
		
		//solodebug alert("submit"); 
		jQuery('#Modelo').submit();
	}
	else
	{
    	jQuery('.bs-callout-info').hide();
    	jQuery('.bs-callout-warning').show();
	}

}


//	Publica la ficha para ser revisada por la central de compras
function CambioEstado(Estado)
{
	
	//solodebug	alert('CambioEstado:'+Estado);
	
	document.forms['Modelo'].elements['ACCION'].value='CAMBIOESTADO';
	
	//	document.forms['Contrato'].elements['PARAMETROS'].value='Estado';
	
	
	jQuery('#Modelo').submit();
}


//	Prepara la recuperación de fichero de disco y el envío según opción seleccionada
function EnviarFichero(files)
{
	//	Inicia la carga del fichero
	var file = files[0];

	var reader = new FileReader();

	reader.onload = function (e) {
		
		console.log('Contenido fichero '+file.name);

		var cuerpoFichero	=e.target.result.replace(/(?:\r\n|\r|\n)/g, '·');
		var totalLineas		=PieceCount(cuerpoFichero, '·');
		var IDModelo		=document.forms['Modelo'].elements['CON_MOD_ID'].value;
		
		ficControlErrores='';
		
		console.log('----- EnviarTodasLineasFichero IDModelo:'+IDModelo+' ('+totalLineas+'):'+cuerpoFichero);
		
		EnviarTodasLineasFichero(IDModelo, file.name, cuerpoFichero, totalLineas, 0);
	};

	reader.readAsText(file);
	
}



//	Enviamos todas las lineas del documento al servidor
function EnviarTodasLineasFichero(IDModelo, nombreFichero, cuerpoFichero, totalLineas, lineaActual)
{
	var d = new Date();
	
	
	if (lineaActual>=totalLineas)
	{
		console.log('EnviarTodasLineasFichero IDModelo:'+IDModelo+' ('+lineaActual+'): FIN ENVIO');
		jQuery('#infoProgreso').html('');
	}
	else
	{
		var Linea=Piece(cuerpoFichero, '·', lineaActual);
		
		var texto='('+(lineaActual+1)+'/'+totalLineas+'):'+Linea;
		//console.log('EnviarTodasLineasFichero INICIO IDModelo:'+IDModelo+' '+texto);

		jQuery.ajax({
			cache:	false,
			//async: false,
			url:	Dominio+'/ProcesosCdC/Contratos/IncluirLineaModeloAJAX.xsql',
			type:	"GET",
			data:	"IDMODELO="+IDModelo
						+"&NOMBRE="+nombreFichero
						+"&NUMLINEA="+lineaActual
						+"&LINEA="+encodeURIComponent(Linea),
			contentType: "application/xhtml+xml",
			error: function(objeto, quepaso, otroobj){
				//
				//	PENDIENTE CONTROL ERRORES
				//
	
				ficControlErrores+='Linea:'+Linea+': ERROR enviando línea<br/>';
				//console.log('enviarProdEstandar [ERROR1]: licNumProductosEnviados:'+licNumProductosEnviados+ ' total:'+ficProductos.length+ ' => ERROR enviando:'+objeto+':'+quepaso+':'+otroobj);
				return 'ERROR';
			},
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				//
				//	Control de errores en la funcion que llama a esta
				//

				//	debug
				console.log('enviarProdEstandar: res:'||data.EnviarLinea.estado);

				//	Procesar error
				if (data.EnviarLinea.estado!='OK')
				{
					console.log('EnviarTodasLineasFichero: ENVIO CORRECTO:'+nombreFichero+' '+texto);
					ficControlErrores+='Linea:'+Linea+':'+data.EnviarLinea.estado+'<br/>';
					jQuery('#infoProgreso').html(texto+'. ERROR.');
				}
				else
				{
					console.log('EnviarTodasLineasFichero: ENVIO CORRECTO:'+nombreFichero+' '+texto);
					jQuery('#infoProgreso').html(texto);

					//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);
				}

				//console.log('enviarProdEstandar: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficProductos[licNumProductosEnviados].RefCat+') '+ficProductos[licNumProductosEnviados].Cat);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				//licNumProductosEnviados=licNumProductosEnviados+1;
				++lineaActual;
				EnviarTodasLineasFichero(IDModelo, nombreFichero, cuerpoFichero, totalLineas, lineaActual);		
				return;
		}
	});


		
	}
	return;

}




//	10feb17 Separamos la creación de la licitación de la preparación del envío
function cerrarFichero(numLineas, estado)
{
	var d= new Date();
	
	estado=OK;		//	11jun18	Si se ha llegado a enviar, aunque hayan algunos errores se marca como procesado

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
//	Mantenimiento de los productos estándar en el catálogo privado
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

	ProcesarClasificacionTXT(Referencias)
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
		var RefCat, Cat, RefFam, Fam, RefSF, SF, RefGru, Gru;
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

		//solodebug		
		console.log('MantenLineasTXT. Linea ('+i+')'+':'+Linea+'. RefCat:'+RefCat+'. Cat:'+Cat+'. RefFam:'+RefFam
					+'. Fam:'+Fam+'. RefSF:'+RefSF+'. SF:'+SF+'. RefGru:'+RefGru+'. Gru:'+Gru);

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
			items['IDLinea'] = '';							//	inicializaremos vía ajax

			//	Comprobar campos obligatorios
			
			//	Referencia
			if (RefCat=='')
			{
				licAvisosCarga += '('+(i+1)+') '+strRefCatObligatoria +'<br/>';
			}
			
			//	Nombre
			if (Cat=='')
			{
				licAvisosCarga += '('+(i+1)+') '+Cat+': '+strCatObligatoria +'<br/>';
			}
			
			//	Referencia
			if (RefFam=='')
			{
				licAvisosCarga += '('+(i+1)+') '+RefCat+': '+strRefFamObligatoria +'<br/>';
			}
			
			//	Nombre
			if (Fam=='')
			{
				licAvisosCarga += '('+(i+1)+') '+RefFam+': '+strFamObligatoria +'<br/>';
			}
			
			//	Referencia
			if (RefSF=='')
			{
				licAvisosCarga += '('+(i+1)+') '+RefFam+': '+strRefSFObligatoria +'<br/>';
			}
			
			//	Nombre
			if (SF=='')
			{
				licAvisosCarga += '('+(i+1)+') '+RefSF+': '+strSFObligatoria +'<br/>';
			}
			
			//	Referencia
			if (RefGru=='')
			{
				licAvisosCarga += '('+(i+1)+') '+RefSF+': '+strRefGruObligatoria +'<br/>';
			}
			
			//	Nombre
			if (Gru=='')
			{
				licAvisosCarga += '('+(i+1)+') '+RefGru+': '+strGruObligatorio +'<br/>';
			}
				
 			ficProductos.push(items);

			//solodebug
			console.log('MantenLineasTXT. Linea ('+i+'). RefCat:'+RefCat+'. Cat:'+Cat+'. RefFam:'+RefFam
					+'. Fam:'+Fam+'. RefSF:'+RefSF+'. SF:'+SF+'. RefGru:'+RefGru+'. Gru:'+Gru+ ' Avisos:'+licAvisosCarga);
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

	var texto	=licNumProductosEnviados+'/'+ficProductos.length+': ['+ficProductos[licNumProductosEnviados].RefGru+'] '+ficProductos[licNumProductosEnviados].Gru;
		
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
				console.log('EnviarTodosClasificacion [ERROR2]. ERROR ENVIANDO: ('+ficProductos[licNumProductosEnviados].RefCat+') '+ficProductos[licNumProductosEnviados].Cat);
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+ficProductos[licNumProductosEnviados].RefCat+') '+ficProductos[licNumProductosEnviados].Cat+':'+data.EnviarLinea.estado+'<br/>';
				licNumProductosEnviados=licNumProductosEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('EnviarTodosClasificacion: ENVIO CORRECTO. IDProdEstandar:'+data.EnviarLinea.idproducto+' -> ('+ficProductos[licNumProductosEnviados].RefCat+') '+ficProductos[licNumProductosEnviados].Cat);

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
