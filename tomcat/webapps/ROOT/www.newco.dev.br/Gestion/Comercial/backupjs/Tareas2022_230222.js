//	JS correspondiente a Tareas de la Gesti�n COmercial
// �ltima revisi�n: 23feb22 12:00 Tareas2022_230222.js


jQuery(document).ready(globalEvents);

function globalEvents(){
  var numRows = jQuery("select#NumLineas").val();
  mostrarLineas(numRows);
}

function Inicio()
{
	var parentLoc=window.parent.location.toString();
	if (parentLoc.indexOf('Main')===-1)
	{
		//console.log('Inicio.'+window.parent.location+'.'+window.top.location+' -> Ocultar bot�n');
		jQuery('#btnSeguimiento').hide();
	}
}

function mostrarLineas(num){
  var trs =  jQuery("table#ListaTareas > tbody > tr");

  if(num == 'todas'){
    trs.show();
    return;
  }

  trs.hide();
  trs.slice(0, num).show();
}

function CambiarEmpresaID(idEmpresa){
  document.forms.Admin.elements.FIDEMPRESA.value = idEmpresa;
  CambiarEmpresa();
}

// Env�a el formulario (bot�n 'Buscar')
function BuscarTareas()
{
	//document.forms.Admin.submit();
	Enviar();
}

// Env�a el formulario (llamada desde otra funci�n)
function Enviar()
{
	document.forms.Admin.method="post";
	document.forms.Admin.action="Tareas2022.xsql";
	document.forms.Admin.submit();
}

// Busca ID, asigna acci�n y env�a formulario
function BorrarGestion(IDGestion){
	document.forms.Admin.elements.ACCION.value = 'BORRAR';
	document.forms.Admin.elements.PARAMETROS.value = IDGestion;

	if (IDGestion !== '') Enviar();
	else alert(document.forms.mensajeJS.elements.FALTA_INFORMAR_GESTION_BORRAR.value);
}

// cambioestado tarea
function CambiarEstadoGestion(IDGestion, estado){
	document.forms.Admin.elements.ACCION.value = 'CAMBIARESTADO';
        var parametros = IDGestion + '|' + estado;
	document.forms.Admin.elements.PARAMETROS.value = parametros;

	if (IDGestion !== '') Enviar();
	else alert(document.forms.mensajeJS.elements.FALTA_INFORMAR_GESTION_BORRAR.value);
}

function EditarGestion(IDGestion){
  var d = new Date();

  jQuery.ajax({
    url:"http://www.newco.dev.br/Gestion/Comercial/TareaAJAX.xsql",
    data: "IDGESTION="+IDGestion+"&_="+d.getTime(),
    type: "GET",
    async: false,
    contentType: "application/xhtml+xml",
    error:function(objeto, quepaso, otroobj){
      alert("objeto:"+objeto);
      alert("otroobj:"+otroobj);
      alert("quepaso:"+quepaso);
    },
    success:function(objeto){

		var data = JSON.parse(objeto);

   	  //var data = eval("(" + objeto + ")");

      	if(data.Tarea.Error)
		{
        	// No se han encontrado datos
        	alert(no_hay_datos);
      	}
		else
		{
	    	jQuery("#ACCION").val('MODIFICAR');

        	// Publicamos valores para el t�tulo del pop-up
        	jQuery('#NombreAutor').html(data.Tarea.Autor);
        	jQuery('#NombreEmpresa').html(data.Tarea.Empresa);
        	jQuery('#FechaTarea').html(data.Tarea.Fecha);

        	// Publicamos valores para los input hidden necesarios para modificar la tarea
        	jQuery('#GT_IDGestion').val(data.Tarea.ID);
        	//jQuery('#GT_IDResponsable').val(data.Tarea.IDResponsable);
        	jQuery('#GT_IDEmpresa').val(data.Tarea.IDEmpresa);

        	// Publicamos los valores de los campos visibles del formulario
        	//jQuery('#GT_Responsable').html(data.Tarea.Responsable);
        	/*jQuery.each(data.Tarea.Responsables, function(index, responsable){
        	  jQuery('#GT_IDResponsable').append(jQuery("<option />").val(responsable.ID).text(responsable.Nombre));
        	});*/
        	jQuery('#GT_IDResponsable').val(data.Tarea.IDResponsable);

        	/*jQuery.each(data.Tarea.Centros, function(index, centro){
        	  jQuery('#GT_IDCentro').append(jQuery("<option />").val(centro.ID).text(centro.Nombre));
        	});*/
        	jQuery('#GT_IDCentro').val(data.Tarea.IDCentro);
        	/*jQuery.each(data.Tarea.Tipos, function(index, tipo){
        	  jQuery('#GT_IDTipo').append(jQuery("<option />").val(tipo.ID).text(tipo.Nombre));
        	});*/
        	jQuery('#GT_IDTipo').val(data.Tarea.IDTipo);
        	jQuery('input[name="GT_IDVisibilidad"][value="' + data.Tarea.Visibilidad + '"]').prop('checked', true);
        	jQuery('#GT_Texto').val(data.Tarea.Texto);
        	jQuery('#GT_FechaLimite').val(data.Tarea.FechaLimite);
        	/*jQuery.each(data.Tarea.Estados, function(index, estado){
        	  jQuery('#GT_IDEstado').append(jQuery("<option />").val(estado.ID).text(estado.Nombre));
        	});*/
        	jQuery('#GT_IDEstado').val(data.Tarea.IDEstado);
        	/*jQuery.each(data.Tarea.Prioridades, function(index, prioridad){
        	  jQuery('#GT_IDPrioridad').append(jQuery("<option />").val(prioridad.ID).text(prioridad.Nombre));
        	});*/
        	jQuery('#GT_IDPrioridad').val(data.Tarea.IDPrioridad);

			var nombreDoc=data.Tarea.NombreDoc;
			var IDDoc=data.Tarea.IDDocumento;
			var URLDoc=data.Tarea.URLDoc;
			var fechaDoc=data.Tarea.FechaDoc;

			jQuery("#inputFileDoc").hide();
			jQuery("#docSubido").html('<a target="_blank" href="http://www.newco.dev.br/Documentos/'+URLDoc+'">'+nombreDoc+'</a>');
			jQuery("#divDatosDocumento").show();

			//solodebug 
			debug('Editar: <a target="_blank" href="http://www.newco.dev.br/Documentos/'+URLDoc+'">'+nombreDoc+'</a>');

			jQuery("#IDDOCUMENTO").val(IDDoc);


        	// Mostramos el pop-up
        	showTablaByID("EditarGestionWrap");
		}
    }
  });
}

function guardarTarea()
{
	var IDGestion = jQuery("#GT_IDGestion").val();
	var IDResponsable = jQuery("#GT_IDResponsable").val();
	var IDEmpresa = jQuery("#GT_IDEmpresa").val();
	var Texto = jQuery("#GT_Texto").val();
	var msg = '';

	//Solodebug  
	console.log('guardarTarea GT_IDEmpresa:'+jQuery("#GT_IDEmpresa").val()+' IDEmpresa:'+IDEmpresa);


	if ((jQuery("#GT_FechaLimite").val() !== '')&&(CheckDate(jQuery("#GT_FechaLimite").val()) !== ''))
	{
			msg = document.forms.mensajeJS.elements.FORMATO_FECHA_LIMITE_NO_OK.value;
	}

	if((IDGestion === '') && (jQuery("#ACCION").val()==='MODIFICAR'))
		msg = document.forms.mensajeJS.elements.FALTA_INFORMAR_GESTION_MODIFICAR.value;

	if(msg !== '')
		alert(msg);
	else
	{
		var parametros = IDGestion + '|' +
    		'|' + IDResponsable +
    		'|' + IDEmpresa +
    		'|' + jQuery('#GT_IDCentro').val() +
    		'|' + jQuery('#GT_FechaLimite').val() +
    		'|' + jQuery('#GT_IDTipo').val() +
    		'|' + Texto +
    		'|' + jQuery('#GT_IDPrioridad').val() +
    		'|' + jQuery('#GT_IDEstado').val() +
    		'|' + jQuery('input[type="radio"][name="GT_IDVisibilidad"]:checked').val() +
    		'|' + jQuery('#IDDOCUMENTO').val();

		jQuery("#PARAMETROS").val(parametros);
		Enviar();
	}
}

// Abre el pop-up para generar nueva tarea
function AbrirNueva()
{
	//  showTablaByID("NuevaGestionWrap");
	jQuery("#ACCION").val('NUEVA');

    // Publicamos valores para el t�tulo del pop-up
    jQuery('#NombreAutor').html(jQuery('#AUTOR').val());
    jQuery('#NombreEmpresa').html(jQuery('#EMPRESA').val());
    jQuery('#FechaTarea').html(jQuery('#FECHA').val());

    // Publicamos valores para los campos necesarios para modificar la tarea
    jQuery('#GT_IDGestion').val('');
    jQuery('#GT_IDEmpresa').val(jQuery('#IDEMPRESA').val());

	//Solodebug  
	console.log('guardarTarea GT_IDEmpresa:'+jQuery("#GT_IDEmpresa").val()+' jQuery(#IDEMPRESA).val():'+jQuery('#IDEMPRESA').val());


    jQuery('#GT_IDResponsable').val('');
    jQuery('#GT_IDCentro').val('');
    jQuery('#GT_IDTipo').val('');
    jQuery('input[name="GT_IDVisibilidad"][value="CENTRO"]').prop('checked', true);
    jQuery('#GT_Texto').val('');
    jQuery('#GT_FechaLimite').val('');
    jQuery('#GT_IDEstado').val('');
    jQuery('#GT_IDPrioridad').val('');

	jQuery("#inputFileDoc").show();
	jQuery("#divDatosDocumento").hide();

	jQuery("#IDDOCUMENTO").val('')

    // Mostramos el pop-up
    showTablaByID("EditarGestionWrap");

}

