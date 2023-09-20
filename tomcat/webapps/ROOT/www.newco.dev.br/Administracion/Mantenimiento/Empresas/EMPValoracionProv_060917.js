// Última revisión: ET 7set17 13:06


function mostrarLineas(num){
  var trs =  jQuery("table#ListaSeguimiento > tbody > tr");

  if(num == 'todas'){
    trs.show();
    return;
  }

  trs.hide();
  trs.slice(0, num*2).show();
}

// Envía el formulario (llamada desde otra función)
function Enviar(){
	SubmitForm(document.forms.formValoracion);
}

//	Borrar entrada de seguimiento
function Borrar(IDRegistro){
	document.forms.formValoracion.elements.ACCION.value = 'BORRAR';
	document.forms.formValoracion.elements.PARAMETROS.value = IDRegistro;

	Enviar();
}

// Abre el pop-up para generar nuevo seguimiento
function AbrirNuevaValoracion(){
  jQuery('#NV_VIS_PUBLICO').attr('checked','checked');
  jQuery('#NV_NOTACALIDAD').val('');
  jQuery('#NV_NOTASERVICIO').val('');
  jQuery('#NV_NOTAPRECIO').val('');
  jQuery('#NV_TEXTO').val('');
  jQuery('.rating-holder span.rating span').html('0');
  jQuery('.rating-holder').each(function(i, obj) {
    jQuery('ul li').each(function(j, obj2) {
      jQuery(this).removeClass("active");
    });
  });

  showTablaByID("NuevaValoracionWrap");
}


function nuevaValoracion(){
  var msg = '';

	var IDEmpresa     = jQuery("#NV_IDEmpresa").val();
	var IDVisibilidad = jQuery("input[type='radio'][name='NV_IDVISIBILIDAD']:checked").val();
	var NotaCalidad   = jQuery("#NV_NOTACALIDAD").val();
	var NotaServicio  = jQuery("#NV_NOTASERVICIO").val();
	var NotaPrecio    = jQuery("#NV_NOTAPRECIO").val();
	var Comentario    = jQuery("#NV_COMENTARIO").val();


  if(NotaCalidad !== '' && NotaServicio !== '' && NotaPrecio !== ''){
    
	/*document.forms.formValoracion.elements.ACCION.value = 'NUEVA';
    document.forms.formValoracion.elements.PARAMETROS.value = '|' +
        '|' +
        '|' + Comentario.replace(/<br \/>/gi,'\n') +
        '|' + IDVisibilidad;
    document.forms.formValoracion.elements.NOTA_CALIDAD.value  = NotaCalidad;
    document.forms.formValoracion.elements.NOTA_SERVICIO.value = NotaServicio;
    document.forms.formValoracion.elements.NOTA_PRECIO.value   = NotaPrecio;*/

    //6set17	Enviar();
	EnviarAjax();
  }else{
    if(NotaCalidad === ''){
      //msg += notaCalidadObli + '\n';
      msg += Query("#notaCalidadObli").val() + '\n';
    }
    if(NotaServicio === ''){
      //msg += notaServicioObli + '\n';
      msg += Query("#notaServicioObli").val() + '\n';
    }
    if(NotaPrecio === ''){
      //msg += notaPrecioObli + '\n';
      msg += Query("#notaPrecioObli").val() + '\n';
    }
    alert(msg);
  }
}


//	6set17	ENviar el formulario de valoración vía Ajax
function EnviarAjax()
{
	var IDEmpresa     = jQuery("#NV_IDEmpresa").val();
	var Visibilidad = jQuery("input[type='radio'][name='NV_IDVISIBILIDAD']:checked").val();
	var NotaCalidad   = jQuery("#NV_NOTACALIDAD").val();
	var NotaServicio  = jQuery("#NV_NOTASERVICIO").val();
	var NotaPrecio    = jQuery("#NV_NOTAPRECIO").val();
	var Comentario    = jQuery("#NV_COMENTARIO").val();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPValoracionProvAjax.xsql',
		type:	"GET",
		data:	"IDEMPRESA="+IDEmpresa+"&VISIBILIDAD="+Visibilidad+"&NOTACALIDAD="+NotaCalidad+"&NOTASERVICIO="+NotaServicio+"&NOTAPRECIO="+NotaPrecio+"&COMENTARIO="+Comentario,
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
		
			var data = eval("(" + objeto + ")"); 

			if(data.Valoracion.estado == 'OK'){
			
				showTabla(false); 
				location.reload();
				
			}else{
				alert(oForm.elements['ERROR_INSERTAR_DATOS'].value);
			}
		}
	});
}


