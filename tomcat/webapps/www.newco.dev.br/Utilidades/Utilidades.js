function normalizarString(cadena, callback){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Utilidades/NormalizarStringAJAX.xsql',
		type:	"GET",
		async:	false,
		data:	"CADENA="+encodeURIComponent(cadena)+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
                        callback('');
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			callback(data.StringNormalizado);
		}
	});
}