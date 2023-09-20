
//etiquetas

jQuery(document).ready(globalEtiquetas);

function globalEtiquetas(){
  if(IDRegistro.length){
    checkEtiquetas();
  }
}

function checkEtiquetas(){
    var d = new Date();

    jQuery.ajax({
      cache:	false,
      url:	'http://www.newco.dev.br/Gestion/Comercial/CheckEtiquetasAJAX.xsql',
      type:	"GET",
      data:	"IDTIPO="+IDTipo+"&IDREGISTRO="+IDRegistro+"&_="+d.getTime(),
      contentType: "application/xhtml+xml",
      beforeSend: function(){
        jQuery('#conEtiquetas').hide();
        jQuery('#sinEtiquetas').hide();
      },
      error: function(objeto, quepaso, otroobj){
        alert('error'+quepaso+' '+otroobj+' '+objeto);
      },
      success: function(objeto){
        var data = eval("(" + objeto + ")");

        if(data.CheckEtiquetas.estado == 'OK'){
          if(data.CheckEtiquetas.cont > 0){
            jQuery('#conEtiquetas').show();
          }else{
            jQuery('#sinEtiquetas').show();
          }
        }
      }
    });
}

function abrirEtiqueta(bool){

  if(bool){
    var d = new Date();

    jQuery.ajax({
  		cache:	false,
  		url:	'http://www.newco.dev.br/Gestion/Comercial/getEtiquetasAJAX.xsql',
  		type:	"GET",
  		data:	"IDREGISTRO="+IDRegistro+"&TIPO="+IDTipo+"&_="+d.getTime(),
  		contentType: "application/xhtml+xml",
  		beforeSend: function(){
  			jQuery("#verEtiquetas #mensError").hide();
  			jQuery("#verEtiquetas table#viejasEtiquetas tbody").empty();
  			jQuery("#verEtiquetas table#viejasEtiquetas").hide();
  		},
  		error: function(objeto, quepaso, otroobj){
  			alert('error'+quepaso+' '+otroobj+' '+objeto);
  		},
  		success: function(objeto){
  			var data = eval("(" + objeto + ")");

  				if(data.Etiquetas.length){
  					var innerHTML = '';

  					for(var i=0; i<data.Etiquetas.length; i++){
  						innerHTML += '<tr class="e' + data.Etiquetas[i].ID + '"><td class="quince"><strong>' + str_autor + ':</strong></td>';
  						innerHTML += '<td style="text-align:left;">' + data.Etiquetas[i].Autor + '</td>';
  						innerHTML += '<td><strong>' + str_fecha + ':</strong></td>';
  						innerHTML += '<td style="text-align:left;">' + data.Etiquetas[i].Fecha + '</td>';
  						innerHTML += '<td class="dies"><a class="borrarEtiqueta" href="javascript:borrarEtiqueta(' + data.Etiquetas[i].ID + ');"><img src="http://www.newco.dev.br/images/2017/trash.png" title="' + str_borrar + '" alt="' + str_borrar + '"/></a></td></tr>';

  						innerHTML += '<tr class="e' + data.Etiquetas[i].ID + '"><td><strong>' + str_etiqueta + ':</strong></td>';
  						innerHTML += '<td colspan="3" style="text-align:left;">' + data.Etiquetas[i].Texto + '</td>';
  						innerHTML += '<td>&nbsp;</td></tr>';

  						innerHTML += '<tr class="e' + data.Etiquetas[i].ID + '">';
  						innerHTML += '<td colspan="6" style="height:5px;border-bottom:2px solid #3B5998;">&nbsp;</td>';
  						innerHTML += '</tr>';
  					}
  					jQuery("#verEtiquetas table#viejasEtiquetas tbody").append(innerHTML);
  					jQuery("#verEtiquetas table#viejasEtiquetas").show();
  				}
  		}
  	});
  }

  jQuery("#verEtiquetas #TEXTO").val('');
  jQuery("#verEtiquetas #Respuesta").html('').hide();
  jQuery("#verEtiquetas #mensError").hide();
  showTablaByID("verEtiquetas");
}

function guardarEtiqueta(){
//  var IDRegistro	= jQuery('#verEtiquetas #IDREGISTRO').val();
//  var Tipo				= jQuery('#verEtiquetas #TIPO').val();
  var Texto				= encodeURIComponent(jQuery('#verEtiquetas #TEXTO').val().replace(/'/g, "''"));
  var d = new Date();

  jQuery.ajax({
    cache:	false,
    url:	'http://www.newco.dev.br/Gestion/Comercial/NuevaEtiquetaAJAX.xsql',
    type:	"POST",
    data:	"IDREGISTRO="+IDRegistro+"&TIPO="+IDTipo+"&TEXTO="+Texto+"&_="+d.getTime(),
    beforeSend: function(){
      jQuery("#verEtiquetas #Respuesta").html('').hide();
      jQuery("#verEtiquetas #mensError").hide();
      jQuery("#verEtiquetas #botonGuardar").hide();
    },
    success: function(objeto){
      var data = eval("(" + objeto + ")");

      if(data.NuevaEtiqueta.estado == 'OK'){
        checkEtiquetas();
        jQuery('#verEtiquetas #Respuesta').html(str_NuevaEtiquetaGuardada).show();
      }else{
        jQuery('#verEtiquetas #Respuesta').html(str_NuevaEtiquetaError).show();
      }
    },
    error: function(xhr, errorString, exception) {
      alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
    }
  });
  jQuery("#verEtiquetas #botonGuardar").show();
}

function borrarEtiqueta(IDEtiqueta){
  var d = new Date();

  jQuery.ajax({
    cache:	false,
    url:	'http://www.newco.dev.br/Gestion/Comercial/BorrarEtiquetaAJAX.xsql',
    type:	"GET",
    data:	"IDETIQUETA="+IDEtiqueta+"&_="+d.getTime(),
    contentType: "application/xhtml+xml",
    beforeSend: function(){
      jQuery("#verEtiquetas #mensError").hide();
      jQuery("#verEtiquetas .borrarEtiqueta").hide();
    },
    error: function(objeto, quepaso, otroobj){
      alert('error'+quepaso+' '+otroobj+' '+objeto);
    },
    success: function(objeto){
      var data = eval("(" + objeto + ")");

      if(data.BorrarEtiqueta.estado == 'OK'){
        checkEtiquetas();
        jQuery(".e" + IDEtiqueta).hide();
      }
    }
  });
  jQuery("#verEtiquetas .borrarEtiqueta").show();
}
