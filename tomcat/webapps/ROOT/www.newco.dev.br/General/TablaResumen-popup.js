
function showTablaResumen(flag){
	if(flag){
		jQuery(".overlay-container").css("top", jQuery(window).scrollTop());

		jQuery('.overlay-container').fadeIn(function(){
			window.setTimeout(function(){
				jQuery('.window-container').addClass('window-container-visible');
			}, 100);
		});
        }else
		jQuery('.overlay-container').fadeOut().end().find('.window-container').removeClass('window-container-visible');
}

function showTablaResumenEmpresa(flag){
	if(flag){
		jQuery(".overlay-container-2").css("top", jQuery(window).scrollTop());

		jQuery('.overlay-container-2').fadeIn(function(){
			window.setTimeout(function(){
				jQuery('.window-container').addClass('window-container-visible');
			}, 100);
		});
        }else
		jQuery('.overlay-container-2').fadeOut().end().find('.window-container').removeClass('window-container-visible');
}

function tablaResumenEmpresa(IDEmpresa){
	var tHeadHTML = '', tBodyHTML = '';
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/EIS/EISTablaResumenClienteAJAX.xsql',
		type:	"GET",
		data:	"IDPAIS="+IDPais+"&IDEMPRESA="+IDEmpresa+"&TIPO=MENSUAL&IDIDIOMA="+IDIdioma+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery('.overlay-container-2 table thead').empty();
			jQuery('.overlay-container-2 table tbody').empty();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.Indicadores.length > 0){
				tHeadHTML = '<tr>';
					tHeadHTML += '<td>&nbsp;</td>';
					jQuery.each(data.Cabecera, function(key, columna){
						tHeadHTML += '<td>' + columna.Mes + '/' + columna.Anyo + '</td>';
					});
				tHeadHTML += '</tr>';
				jQuery('.overlay-container-2 table thead').append(tHeadHTML);

				jQuery.each(data.Indicadores, function(key, indicador){
					tBodyHTML += '<tr>';
						tBodyHTML += '<td class="indicador">' + indicador.Nombre + '</td>';

						jQuery.each(indicador.Columnas, function(key2, columna){
							tBodyHTML += '<td>' + columna.Valor + '</td>';
						});
					tBodyHTML += '</tr>';
				});
				jQuery('.overlay-container-2 table tbody').append(tBodyHTML);

				showTablaResumenEmpresa(true);
			}
		}
	});
}

