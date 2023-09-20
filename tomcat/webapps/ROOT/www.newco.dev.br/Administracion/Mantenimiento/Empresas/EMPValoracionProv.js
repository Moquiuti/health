// Última revisión: 10dic15

jQuery(document).ready(globalEvents);

function globalEvents(){
  var numRows = jQuery("select#NumLineas").val();
  mostrarLineas(numRows);
}

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
	SubmitForm(document.forms.form1);
}

//	Borrar entrada de seguimiento
function Borrar(IDRegistro){
	document.forms.form1.elements.ACCION.value = 'BORRAR';
	document.forms.form1.elements.PARAMETROS.value = IDRegistro;

	Enviar();
}

// Abre el pop-up para generar nuevo seguimiento
function AbrirNuevo(){
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
  var IDEmpresa     = jQuery("#NV_IDEmpresa").val();
  var IDVisibilidad = jQuery("input[type='radio'][name='NV_IDVISIBILIDAD']:checked").val();
  var NotaCalidad   = jQuery("#NV_NOTACALIDAD").val();
  var NotaServicio  = jQuery("#NV_NOTASERVICIO").val();
  var NotaPrecio    = jQuery("#NV_NOTAPRECIO").val();
  var Comentario    = jQuery("#NV_COMENTARIO").val();
  var msg = '';

  if(NotaCalidad !== '' && NotaServicio !== '' && NotaPrecio !== ''){
    document.forms.form1.elements.ACCION.value = 'NUEVA';
    document.forms.form1.elements.PARAMETROS.value = '|' +
        '|' +
        '|' + Comentario.replace(/<br \/>/gi,'\n') +
        '|' + IDVisibilidad;
    document.forms.form1.elements.NOTA_CALIDAD.value  = NotaCalidad;
    document.forms.form1.elements.NOTA_SERVICIO.value = NotaServicio;
    document.forms.form1.elements.NOTA_PRECIO.value   = NotaPrecio;

    Enviar();
  }else{
    if(NotaCalidad === ''){
      msg += notaCalidadObli + '\n';
    }
    if(NotaServicio === ''){
      msg += notaServicioObli + '\n';
    }
    if(NotaPrecio === ''){
      msg += notaPrecioObli + '\n';
    }
    alert(msg);
  }
}
