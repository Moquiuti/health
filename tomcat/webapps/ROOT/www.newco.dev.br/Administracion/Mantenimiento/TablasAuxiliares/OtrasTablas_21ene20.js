//	JS Mantenimiento de otras tablas auxiliareas, para usuarios MVM
//	Ultima revision: ET 21ene20 09:25 OtrasTablas_21ene20.js

var Dominio='http://www.newco.dev.br';	//	facilita portabilidad

var ficControlErrores='',
	ficID='';

var ficCambios	= new Array();

var sepCampos='|';


function Recargar()
{
	SubmitForm(document.forms[0]);
}


// Si hay cambio de empresa reconstruye el desplegable de centros
function selEmpresaChange()
{
	Recargar();
}


//	Al cambiar de centro se reacarga la página
function selCentroChange()
{
	Recargar();
}

//	Prepara el envío del nuevo registro
function Insertar()
{
	  document.forms[0].elements['ACCION'].value='NUEVO';
	  document.forms[0].elements['PARAMETROS'].value=document.forms[0].elements['IDTIPO'].value
		  												+'|'+document.forms[0].elements['CODIGOMVM'].value
														+'|'+document.forms[0].elements['CODIGOERP'].value;
	  Recargar();
}

//	Prepara para borrar
function Borrar(ID)
{
	if (confirm(str_AvisoBorrar))
	{
	      document.forms[0].elements['ACCION'].value='BORRAR';
	      document.forms[0].elements['PARAMETROS'].value=ID;
		  SubmitForm(document.forms[0]);
	}
}



//	Subida de ficheros


//	Prepara la recuperación de fichero de disco y el envío según opción seleccionada
function EnviarFichero(files)
{
	//	Inicia la carga del fichero
	var file = files[0];

	var reader = new FileReader();

	reader.onload = function (e) {
		
		console.log('Contenido fichero '+file.name);
		ProcesarTablasAuxTXT(e.target.result);
	};

	reader.readAsText(file);
	
}

//	Recupera las TablasAux del area text para procesarlas
function MantenTablasAuxTXT()
{
	var oForm = document.forms[0];

	var TablasAux = oForm.elements['TXT_TABLASAUXILIARES'].value;
	TablasAux = TablasAux.replace(/;/g, '|');				// 	Permitiremos también ";"
	TablasAux = TablasAux.replace(/[\t]/g, '|');			// 	Tabulador para separar columnas en excel -> '|'

	ProcesarTablasAuxTXT(TablasAux);
}


//	Procesa una cadena con el archivo completo de TablasAux a subir
function ProcesarTablasAuxTXT(CadenaCambios)
{
	console.log('ProcesarTablasAuxTXT:'+CadenaCambios);

	var oForm = document.forms[0];
	var licAvisosCarga ='';
	
	jQuery("#TXT_TABLASAUXILIARES").hide();
	jQuery("#btnMantenTablasAux").hide();
	jQuery('#infoErrores').html('');
	
	//solodebug	var Control='';

	CadenaCambios	= CadenaCambios.replace(/·/g, '');						//	Quitamos los caracteres que utilizaremos como separadores
	CadenaCambios	= CadenaCambios.replace(/(?:\r\n|\r|\n)/g, '·');
	
	var numRefs	= PieceCount(CadenaCambios, '·');
	
	//solodebug		alert('rev.15dic17 12:11\n\r'+CadenaCambios);
	
	ficCambios	= new Array();
	ficControlErrores ='';
	
	for (i=0;i<=numRefs;++i)
	{
		var Tipo, CodigoMVM, CodigoERP;
		var Linea= Piece(CadenaCambios, '·',i);

		//solodebug		alert('Linea:['+Linea+']');
		
		col=0;
		Tipo	= Piece(Linea, sepCampos, col);
		++col;
		CodigoMVM	= Piece(Linea, sepCampos, col);
		++col;
		CodigoERP	= Piece(Linea, sepCampos, col);

		//solodebug		
		console.log('ProcesarTablasAuxTXT. Linea ('+i+')'+':'+Linea+'. Tipo:'+Tipo+'. CodigoMVM:'+CodigoMVM+'. CodigoERP:'+CodigoERP);

		licAvisosCarga='';
		if ((Tipo!='TIPO')&&(Tipo!=''))		//	Eliminamos líneas vacias
		{
			var items		= [];
			items['IDEmpresa'] = oForm.elements['IDEMPRESA'].value;
			items['IDCentro'] = oForm.elements['IDCENTRO'].value;
			items['Tipo']	= Tipo;
			items['CodigoMVM']= CodigoMVM;
			items['CodigoERP']= CodigoERP;
			items['IDLinea'] = '';							//	inicializaremos vía ajax

			//	Comprobar campos obligatorios
			//	Tipo
			if (Tipo=='')
			{
				licAvisosCarga += '('+(i+1)+') '+Descripcion+': '+strTipoObligatorio +'<br/>';
			}
			
			//	CodigoMVM
			if (CodigoMVM=='')
			{
				licAvisosCarga += '('+(i+1)+') '+Codigo+': '+strCodigoMVMObligatorio +'<br/>';
			}
			
			//	CodigoERP
			if (CodigoERP=='')
			{
				licAvisosCarga += '('+(i+1)+') '+Codigo+': '+strCodigoERPObligatorio +'<br/>';
			}
				
 			ficCambios.push(items);

		}
		else
		{
			//solodebug
			console.log('Descartando línea en blanco:'+Linea);
		}


	}

	//solodebug	
	console.log('ProcesarTablasAuxTXT. :'+licAvisosCarga);

	if (licAvisosCarga!='')
	{
		jQuery("#TXT_TABLASAUXILIARES").show();
		jQuery('#infoProgreso').hide();
		jQuery('#infoErrores').html(licAvisosCarga);
		jQuery('#infoErrores').show();
	}
	
	//	Control de errores en el proceso
	if (licAvisosCarga=='')
	{
	
		//document.getElementById("infoProgreso").innerHTML = str_Iniciando;
		jQuery('#infoProgreso').show();
		
		ficControlErrores=EnviarTablasAux(ficCambios);
	
	}
	else
	{
		alert(str_ErrSubirRegistro);
	}
	
	jQuery("#btnMantenTablasAux").show();
	jQuery("#TXT_TABLASAUXILIARES").show();

}


//	Enviar cambios
function EnviarTablasAux(ficCambios)
{
	var ficControlErrores='';
	var d= new Date();


	//	Paso 1: Crear licitacion
	document.getElementById("infoProgreso").innerHTML = 'Procesando fichero.';
	//solodebug	document.getElementById("infoProgreso").style.background = 0;
	
	//solodebug	alert('Inicio: infoProgreso:'+jQuery('#infoProgreso').html());
	
	prepararEnvio('MANTENTABLASAUX_'+IDUsuario+'_'+d.getYear()+d.getMonth()+d.getDay()+d.getHours()+d.getMinutes()+d.getSeconds());

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
		
		console.log('EnviarTablasAux. ForzarNombre:'+ForzarNombre);
	
		
		//	Version recursiva
		
		//PENDIENTE
		EnviarTodos(0);
		//PENDIENTE
		
	}
	else
	{
		document.getElementById("infoProgreso").innerHTML = 'Procesando fichero: ERROR:'+ficControlErrores;
	}

	return ficControlErrores;
}


//	2ene17	recuperamos los datos de ofertas de un proveedor
function prepararEnvio(nombreFichero)
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
function EnviarTodos(licNumRegEnviados)
{
	var d		= new Date();
	

	//	Entrada en el proceso
	
	//solodebug
	console.log('EnviarTodos: licNumRegEnviados:'+licNumRegEnviados+ ' total:'+ficCambios.length);

	if (licNumRegEnviados>=ficCambios.length)
	{

		if (ficControlErrores==0)
		{
			//solodebug	
			console.log('EnviarTodos: licNumRegEnviados:'+licNumRegEnviados+ ' total:'+ficCambios.length + ' -> cerrarFichero sin errores');
			
			cerrarFichero(licNumRegEnviados, 'OK');
			jQuery('#infoProgreso').html(str_FicheroProcesado);
			jQuery('#infoProgreso').show();
			jQuery('#infoErrores').hide();
			
			alert(str_FicheroProcesado+': '+ficCambios.length+'/'+ficCambios.length);
			
			ficID='';		//	Para poder reenviar la carga
			selCentroChange();	//recarga, manteniendo el centro
			
			return 'OK';
		}
		else
		{
			//solodebug	
			console.log('EnviarTodos: licNumRegEnviados:'+licNumRegEnviados+ ' total:'+ficCambios.length + ' -> cerrarFichero CON ERROR');
			cerrarFichero(licNumRegEnviados, 'ERROR');
			jQuery('#infoProgreso').hide();
			jQuery('#infoErrores').html(ficControlErrores);
			jQuery('#infoErrores').show();
			
			var msg=ficControlErrores.replace(/<br\/>/g,'\n');

			ficID='';		//	Para poder reenviar la carga

			alert(str_FicheroProcesado+':\n'+msg);
			
			ficID='';		//	Para poder reenviar la carga
			selCentroChange();	//recarga, manteniendo el centro

			return 'ERROR';
		}
	}
	//solodebug
	//else
	//{
	//	console.log('enviarLineaFichero: licNumRegEnviados:'+licNumRegEnviados+ ' total:'+ficCambios.length+ ' => enviando');
	//}

	var texto	=(licNumRegEnviados+1)+'/'+ficCambios.length+': ['+ficCambios[licNumRegEnviados].RefGru+'] '+ficCambios[licNumRegEnviados].Gru;
		
	jQuery.ajax({
		cache:	false,
		//async: false,
		url:	Dominio+'/Administracion/Mantenimiento/TablasAuxiliares/MantenTablasAuxiliaresAJAX.xsql',
		type:	"GET",
		data:	"INTF_ID="+ficID
					+"&NUMLINEA="+licNumRegEnviados
					+"&IDEMPRESA="+ficCambios[licNumRegEnviados].IDEmpresa
					+"&IDCENTRO="+ficCambios[licNumRegEnviados].IDCentro
					+"&TIPO="+ficCambios[licNumRegEnviados].Tipo
					+"&CODIGOMVM="+ficCambios[licNumRegEnviados].CodigoMVM
					+"&CODIGOERP="+ficCambios[licNumRegEnviados].CodigoERP,
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			ficError='ERROR_ENVIANDO';
			//licLineaError=numLineaInicio;
			
			ficControlErrores+=ficControlErrores+str_NoPodidoIncluirRegistro;	//+': ('+ficCambios[licNumRegEnviados].RefEstandar+') '+ficCambios[licNumRegEnviados].Nombre+'<br/>';
			console.log('enviarProdEstandar [ERROR1]: licNumRegEnviados:'+licNumRegEnviados+ ' total:'+ficCambios.length+ ' => ERROR enviando:'+objeto+':'+quepaso+':'+otroobj);
			return 'ERROR';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			
			//
			//	Control de errores en la funcion que llama a esta
			//
						
			ficCambios[licNumRegEnviados].IDProducto=data.EnviarLinea.idregistro;

			//	debug
			console.log('enviarProdEstandar: res:'||data.EnviarLinea.estado);
			
			//	Procesar error
			if (data.EnviarLinea.estado!='OK')
			{
				console.log('EnviarTodos [ERROR2]. ERROR ENVIANDO: ('+licNumRegEnviados+') '+ficCambios[licNumRegEnviados].Codigo);
				ficError='ERROR_ENVIANDO';
				ficControlErrores+='('+licNumRegEnviados+') '+ficCambios[licNumRegEnviados].Codigo+':'+data.EnviarLinea.estado+'<br/>';
				licNumRegEnviados=licNumRegEnviados+1;
				jQuery('#infoProgreso').html(texto+'. ERROR.');
			}
			else
			{
				console.log('EnviarTodos: ENVIO CORRECTO. IDProdEstandar:'+data.EnviarLinea.idregistro+' -> ('+licNumRegEnviados+') '+ficCambios[licNumRegEnviados].Codigo);

				jQuery('#infoProgreso').html(texto);

				//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

				licNumRegEnviados=licNumRegEnviados+1;
			}

			//console.log('enviarProdEstandar: ENVIO CORRECTO. IDProductoLic:'+data.Producto.IDProductoLic+' -> ('+ficCambios[licNumRegEnviados].RefCat+') '+ficCambios[licNumRegEnviados].Cat);

			jQuery('#infoProgreso').html(texto);

			//solodebug	if (numLineaInicio<3) alert("ASINCRONO:"+texto);

			//licNumRegEnviados=licNumRegEnviados+1;
			EnviarTodos(licNumRegEnviados);		

		}
	});
	
}


//	Cierre del fichero, presentar mensaje de error si corresponde
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
