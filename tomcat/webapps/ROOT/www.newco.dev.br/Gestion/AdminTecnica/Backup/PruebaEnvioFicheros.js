//	JS para el envio de fichereos via ajax a la plataforma medicalvm.com
//	ultima revision ET 4ene17 15:58

var IDFichero;

var Status='OK';

var ControlErrores='';
var LineaError='';


//	2ene17	recuperamos los datos de ofertas de un proveedor
function prepararEnvioFichero(nombreFichero){
	var d		= new Date();
	
	jQuery.ajax({
		cache:	false,
		async: false,
		url:	'http://www.newco.dev.br/Gestion/AdminTecnica/PrepararEnvioFichero.xsql',
		type:	"GET",
		data:	"NOMBRE="+nombreFichero+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			ControlErrores='ERROR_CONECTANDO';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			//	Envio correcto de datos

			console.log('prepararEnvioFichero: idfichero:'+data.PrepararEnvio.idfichero);
			
			IDFichero=data.PrepararEnvio.idfichero;
		}
	});
}


//	31dic16	recuperamos los datos de ofertas de un proveedor
function enviarLineaFichero(numLineaInicio, totalLineas, texto){
	var d		= new Date();
	
	jQuery.ajax({
		cache:	false,
		async: false,
		url:	'http://www.newco.dev.br/Gestion/AdminTecnica/EnvioLineaFichero.xsql',
		type:	"GET",
		data:	"INTF_ID="+IDFichero+"&NUMLINEA="+numLineaInicio+"&TEXTO="+encodeURIComponent(texto)+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			ControlErrores='ERROR_ENVIANDO';
			LineaError=numLineaInicio;
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			
			//	Control de errores internos
			if (numLineaInicio+totalLineas-1 != data.EnviarLinea.numlinea)
			{
				ControlErrores='ERROR_ENVIANDO';
				LineaError=numLineaInicio;
			
				alert('enviarLineaFichero: numLineaInicio:'+ numLineaInicio
						+' | totalLineas:'+totalLineas 
						+' | numlinea JSON:'+data.EnviarLinea.numlinea
						+ ' \n\r texto:'+encodeURIComponent(texto));
			}
			
			//	Envio correcto de datos
			//	console.log('enviarLineaFichero: numlinea:'+data.EnviarLinea.numlinea);
		}
	});
	
}


//	2ene17	recuperamos los datos de ofertas de un proveedor
function finEnvioFichero(numeroLineas){
	var d		= new Date();
	
	jQuery.ajax({
		cache:	false,
		async: false,		//	Quitamos el asincrono. Sera mas lento, pero mas controlable.
		url:	'http://www.newco.dev.br/Gestion/AdminTecnica/FinEnvioFichero.xsql',
		type:	"GET",
		data:	"IDFICHERO="+IDFichero+"&NUMLINEAS="+numeroLineas+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			ControlErrores='ERROR_CERRANDO';
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			//	Envio correcto de datos
			console.log('finEnvioFichero: idfichero:'+data.FinEnvio.idfichero);
		}
	});
}




function enviarFichero(files) {
	var file = files[0];

	var reader = new FileReader();

	reader.onload = function (e) {
		// Cuando éste evento se dispara, los datos están ya disponibles.
		//var output = document.getElementById("fileOutput");
		//output.textContent = e.target.result;

		jQuery('#lineaActual').html('Preparando envio');
		//$('#lineaActual').redraw();
		
		var IDFichero=prepararEnvioFichero(file.name);
		
		var cadenaCompleta=e.target.result;
		var cadenaEnvio='', cadenaLarga='',cadenaRespuesta='', totalEnvio='', totalRespuesta='';
		
		var longCad=cadenaCompleta.length;
		var count=0;
		var lineasAgrupadas=0;
		
		var Pos=cadenaCompleta.indexOf('\n');
		while ((Pos>0) && (ControlErrores=='') && (count<20000))		//count solo para evitar errores, hasta 20.000 lineas
		{
			++lineasAgrupadas;	//PENDIENTE ENVIAR LAS LINEAS DE 10 en 10 en lugar de 1 en 1
			
			cadenaEnvio=cadenaCompleta.substring(0, Pos);
			cadenaLarga+=cadenaEnvio+'[FINLINEA]';
			
			cadenaCompleta=cadenaCompleta.substring(Pos+1);	//	Quitamos la cadena y los caracteres \n\r
			
			//	Pendiente limpiar otros caracteres especiales	\t
			
			if (lineasAgrupadas==10)
			{
				//	Enviamos el texto via Ajax
				cadenaRespuesta=enviarLineaFichero(count, lineasAgrupadas, cadenaLarga);

				jQuery('#lineaActual').html('Contador: '+count+' lineas enviadas.');
				count+=lineasAgrupadas;
				totalEnvio+=cadenaLarga+'[FINBLOQUE]';
				cadenaLarga='';
				lineasAgrupadas=0;
			}			
			
			
			//$('#lineaActual').redraw();

			totalRespuesta+='['+cadenaRespuesta+']<br/><br/>';
			Pos=cadenaCompleta.indexOf('\n');
		}
		
		//	Enviamos las lineas que hayan quedado
		if ((ControlErrores=='')&&(lineasAgrupadas>0))
		{
			cadenaRespuesta=enviarLineaFichero(count, lineasAgrupadas, cadenaLarga);
			count+=lineasAgrupadas;

			jQuery('#lineaActual').html('Contador: '+count+' lineas enviadas. ULTIMO BLOQUE.');
			totalEnvio+=cadenaLarga+'[FINBLOQUE]';
		}

		if (ControlErrores=='')
			finEnvioFichero(IDFichero, count);
		
		//	Control de errores en el proceso
		if (ControlErrores=='')
		{

			jQuery('#lineaActual').html('Contador: '+count+' lineas enviadas. FIN ENVIO.');
			//$('#lineaActual').redraw();
			jQuery('#siguienteTarea').html('Preparando para ejecutar la carga.');

			jQuery('#fileOutput').html('FICHERO:<br/><br/>'+e.target.result+'<br/><br/>CADENA ENVIO:<br/><br/>'+totalEnvio);		//+'<br/><br/>CADENA RESPUESTAS:<br/><br/>'+totalRespuesta
		}
		else
		{
			alert(ControlErrores);
		}
		
	};

	reader.readAsText(file);
}
