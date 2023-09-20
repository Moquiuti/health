//	JS correspondiente al Seguimiento de la Gestión COmercial
// Última revisión: 5jun19 11:07

jQuery(document).ready(globalEvents);

function globalEvents(){
  var numRows = jQuery("select#NumLineas").val();
  mostrarLineas(numRows);
}

function mostrarLineas(num){
  var trs =  jQuery("table#ListaSeguimiento > tbody > tr");

	//solodebug
	console.log('mostrarLineas:'+num);

  if(num == 'todas'){
    trs.show();
    return;
  }

  trs.hide();
  trs.slice(0, num*2).show();
}

//checkbox desplegable empresa
function soloClientes(oForm){
  if(oForm.elements.SOLO_CLIENTES_CK.checked === true){
    oForm.elements.SOLO_PROVEE_CK.checked = false;
  }
  DesplegableEmpresa(oForm);
}

function soloProvee(oForm){
  if(oForm.elements.SOLO_PROVEE_CK.checked === true){
    oForm.elements.SOLO_CLIENTES_CK.checked = false;
  }
  DesplegableEmpresa(oForm);
}


function DesplegableEmpresa(oForm)
{
  oForm.elements.SOLO_PROVEE.value = (oForm.elements.SOLO_PROVEE_CK.checked === true) ? 'S' : 'N';
  oForm.elements.SOLO_CLIENTES.value = (oForm.elements.SOLO_CLIENTES_CK.checked === true) ? 'S' : 'N';

  var idEmpresa;
  if(oForm.elements.IDEMPRESA.value !== ''){
    idEmpresa = oForm.elements.IDEMPRESA.value;
  }else{
    idEmpresa  = '-1';
  }

	var marca = 'EMPRESAS';
	var nombreCampo = 'FIDEMPRESA';
	var IDEmpresaUsuario = oForm.elements.IDEMPRESAUSUARIO.value;
	var idPais = oForm.elements.IDPAIS.value;
	var soloClientes = oForm.elements.SOLO_CLIENTES.value;
	var soloProvee = oForm.elements.SOLO_PROVEE.value;
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/DesplegableEmpresa.xsql',
		type:	"GET",
		data:	"MARCA="+marca+"&NOMBRECAMPO="+nombreCampo+"&IDPAIS="+idPais+"&IDEMPRESA="+idEmpresa+"&SOLO_CLIENTES="+soloClientes+"&SOLO_PROVEE="+soloProvee+"&IDEMPRESAUSUARIO="+IDEmpresaUsuario+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

      if(data.Filtros !== ''){
        jQuery('#FIDEMPRESA').empty();
        for(var i=0; i<data.Filtros.length; i++){
          jQuery('#FIDEMPRESA').append(jQuery("<option />").val(data.Filtros[i].Fitro.id).text(data.Filtros[i].Fitro.nombre));
        }
      }
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}

//	Mostrar otra empresa, solo llama a Enviar sin ninguna acción
function CambiarEmpresa()
{
	Enviar();
}

function CambiarEmpresaID(idEmpresa)
{
	document.forms.frmSeg.elements.FIDEMPRESA.value = idEmpresa;
	CambiarEmpresa();
}

// Envía el formulario (llamada desde otra función)
function Enviar()
{
	document.forms.frmSeg.method="post";
	document.forms.frmSeg.action="Seguimiento.xsql";
	SubmitForm(document.forms.frmSeg);
}

/*
function Modificar(IDRegistro)
{
	document.forms['frmSeg'].elements["ACCION"].value='MODIFICAR';
	document.forms['frmSeg'].elements["PARAMETROS"].value=IDRegistro+'|'+document.forms['frmSeg'].elements["IDCENTRO_"+IDRegistro].value+'|'+document.forms['frmSeg'].elements["IDTIPO_"+IDRegistro].value+'|'+document.forms['frmSeg'].elements["TEXTO_"+IDRegistro].value+'|'+document.forms['frmSeg'].elements["VISIBILIDAD_"+IDRegistro].value;

	Enviar();
}
*/

// Editar entrada de seguimiento
function Editar(IDRegistro){
	var d = new Date();

    jQuery("#ACCION").val('MODIFICAR');

	jQuery.ajax({
    	url:"http://www.newco.dev.br/Gestion/Comercial/SeguimientoAJAX.xsql",
    	data: "IDENTRADA="+IDRegistro+"&_="+d.getTime(),
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

    	  if(data.Seguimiento.Error){
        	// No se han encontrado datos
        	alert(no_hay_datos);
    	  }else{
        	// Publicamos valores para el título del pop-up
        	jQuery('#NombreEmpresa').html(data.Seguimiento.Empresa);
        	jQuery('#FechaSeguimiento').html(data.Seguimiento.Fecha);

        	// Publicamos valores para los input hidden necesarios para modificar la entrada de seguimiento
        	jQuery('#ES_IDEntrada').val(data.Seguimiento.ID);
        	jQuery('#ES_IDEmpresa').val(data.Seguimiento.IDEmpresa);
        	jQuery('#ES_IDCentro').val(data.Seguimiento.IDCentro);
        	jQuery('#ES_IDTipo').val(data.Seguimiento.IDTipo);

        	jQuery('input[name="ES_IDVisibilidad"][value="' + data.Seguimiento.Visibilidad + '"]').prop('checked', true);

        	jQuery('#ES_TEXTO').val(data.Seguimiento.Texto.replace(/<br>/gi,'\n'));

			var nombreDoc=data.Seguimiento.NombreDoc;
			var	IDDoc=data.Seguimiento.IDDocumento;
			var URLDoc=data.Seguimiento.URLDoc;
			var fechaDoc=data.Seguimiento.FechaDoc;

			jQuery("#inputFileDoc").hide();
			jQuery("#docSubido").html('<a target="_blank" href="http://www.newco.dev.br/Documentos/'+URLDoc+'">'+nombreDoc+'</a>');
			jQuery("#divDatosDocumento").show();

			//solodebug 
			debug('Editar: <a target="_blank" href="http://www.newco.dev.br/Documentos/'+URLDoc+'">'+nombreDoc+'</a>');

			jQuery("#IDDOCUMENTO").val(IDDoc);

        	showTablaByID("EditarSeguimientoWrap");
	   	  }
    	}
	  });
}

function guardarSeguimiento(){
  var IDEntrada = jQuery("#ES_IDEntrada").val();
  var IDEmpresa = jQuery("#ES_IDEmpresa").val();
  var IDCentro  = jQuery("#ES_IDCentro").val();
  var Texto = jQuery("#ES_TEXTO").val();
  var msg = '';

  if(Texto === '')
    msg += alrt_FaltaDescripcion+'\n';

  if(msg !== '')
    alert(msg);
  else{
    var parametros = IDEntrada +
        '|' + IDCentro +
        '|' + jQuery('#ES_IDTipo').val() +
        '|' + Texto.replace(/<br \/>/gi,'\n') +
        '|' + jQuery('input[type="radio"][name="ES_IDVisibilidad"]:checked').val() +
        '|' + jQuery('#IDDOCUMENTO').val()
		;

    jQuery("#PARAMETROS").val(parametros);

    Enviar();
  }
}

//	Borrar entrada de seguimiento
function Borrar(IDRegistro){
	document.forms.frmSeg.elements.ACCION.value = 'BORRAR';
	document.forms.frmSeg.elements.PARAMETROS.value = IDRegistro;

	Enviar();
}

// Abre el pop-up para generar nuevo seguimiento
function AbrirNuevo()
{
    document.forms.frmSeg.elements.ACCION.value = 'NUEVA';

	//solodebug
	debug('AbrirNuevo. Empresa:'+jQuery('#EMPRESA').val()+' Fecha:'+jQuery('#FECHA').val());

    // Publicamos valores para el título del pop-up
    jQuery('#NombreEmpresa').html(jQuery('#EMPRESA').val());
    jQuery('#FechaSeguimiento').html(jQuery('#FECHA').val());

    // Publicamos valores para los input hidden necesarios para modificar la entrada de seguimiento
    jQuery('#ES_IDEntrada').val('');
    jQuery('#ES_IDCentro').val('');
    jQuery('input[name="ES_IDVisibilidad"][value="CENTRO"]').prop('checked', true);
    jQuery('#ES_TEXTO').val('');

	jQuery("#inputFileDoc").show();
	jQuery("#divDatosDocumento").hide();

	jQuery("#IDDOCUMENTO").val('')

    showTablaByID("EditarSeguimientoWrap");
}


// 18may16	ET	LLamada al buscador
function Buscador()
{
    jQuery("#ACCION").val('');
	Enviar();
}




