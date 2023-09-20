//	Libreria para descarga de ficheros en formato nativo. Utilizado desde EISInformesHTML.xsl.
//	Ultima revision: ET 15nov17 13:31


function DescargaMIME(content, fileName, mimeType) 
{

	//solodebug	console.log('download: fileName:'+fileName+' mimeType:'+mimeType+content.substring(0, 100) +'...');


  var a = document.createElement('a');
  mimeType = mimeType || 'application/octet-stream';

  if (navigator.msSaveBlob) { // IE10
    navigator.msSaveBlob(new Blob([content], {
      type: mimeType
    }), fileName);
  } else if (URL && 'download' in a) { //html5 A[download]
    a.href = URL.createObjectURL(new Blob([content], {
      type: mimeType
    }));
    a.setAttribute('download', fileName);
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
  } else {
    location.href = 'data:application/octet-stream,' + encodeURIComponent(content); // only this mime type is supported
  }
}


function RecuperaCSV_Ajax(Enlace)
{
	var contenidoCSV;


	jQuery.ajax({
    	// En data puedes utilizar un objeto JSON, un array o un query string
    	data: {"parametro1" : "valor1", "parametro2" : "valor2"},
    	//Cambiar a type: POST si necesario
    	type: "GET",
    	// Formato de datos que se espera en la respuesta
    	dataType: "text",
    	// URL a la que se enviará la solicitud Ajax
    	url: Enlace,
	})
	 .done(function( data, textStatus, jqXHR ) {
    	 if ( console && console.log ) {
			contenidoCSV=data.replace( /\t/g,'').replace( /#/g,'').replace(/&amp;/g,'&');			//limpiamos tabuladores y '#' (que sirve para forzar fuin de linea en XSL), &amp; -> &

			DescargaMIME(contenidoCSV, 'Informe.csv', 'text/csv;encoding:utf-8');

    	 }
	 })
	 .fail(function( jqXHR, textStatus, errorThrown ) {
    	 if ( console && console.log ) {
        	 console.log( "La solicitud a fallado: " +  textStatus);
    	 }
	});


}
