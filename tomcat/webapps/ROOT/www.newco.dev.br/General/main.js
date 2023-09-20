//	29nov16	ET	Biblioteca con funciones necesarias en todas las páginas,
//				en particular para la manipulación de formularios dentro de DIVs
//
//	Ult.revision 29nov16	10:47


function fixedEncodeURIComponent (str) {
	return encodeURIComponent(str);	//.replace(/[!'()]/g, escape).replace(/\*/g, "%2A");
}



//	Envía todos los campos de un form vía ajax
//	Procesa los checkboxes y areatext para que no den errores
function EnviarFormViaAjax(nombreForm, urlDestino, nombreTarget)
{

	console.log('EnviarFormViaAjax: form:'+nombreForm+' url:'+urlDestino+' target'+nombreTarget);

	jQuery("#"+nombreTarget).html('Preparando consulta');

	var sURL='';

	var jsonString='';

    jQuery("#"+nombreForm).find(':input').each(function() {
		var campo=this;

		sURL=sURL+(sURL==''?'':'&')+campo.name+'='+encodeURIComponent(campo.value);

		jsonString=jsonString+(jsonString==''?'':',')+'"'+campo.name+'":"'+encodeURIComponent(campo.value)+'"';
	});

	jsonString='{'+jsonString+'}';

	console.log('URL:'+sURL); 
	console.log('jsonString:'+jsonString); 

	var jsoObj = JSON.parse(jsonString);
alert('JSON parse: '+jsoObj);
	//	Version Post (esta recargando toda la pagina)
	//$.post("http://www.newco.dev.br/prueba.xsql", jsonObj, function(htmlexterno){
	//	$("#resultado").html('Resultado:'+htmlexterno);
	//});

	alert('Ajax!');

	//	Versión con peticion Ajax
	jQuery.ajax({
    	url: urlDestino,
    	dataType: 'json',
    	type: 'post',
    	contentType: 'application/json',
    	data: jsoObj,
    	processData: false,
    	success: function( data, textStatus, jQxhr ){
        	//$("#"+nombreTarget).html( JSON.stringify( data ) );
        	jQuery("#"+nombreTarget).html( data );
    	},
    	error: function( jqXhr, textStatus, errorThrown ){
        	console.log( errorThrown );
    	}
	});

	alert('Fin ajax!');

}	//	EnviarFormViaAjax


//	Envía todos los campos de un form vía ajax
//	Procesa los checkboxes y areatext para que no den errores
function EnviarFormPrincipalViaAjax(nombreForm, urlDestino)
{
	EnviarFormViaAjax(nombreForm, urlDestino, 'Main');
}



