// Última revisión: 11nov15

jQuery(document).ready(globalEvents);

function globalEvents(){
  var numRows = jQuery("select#NumLineas").val();
  mostrarLineas(numRows);
}

function mostrarLineas(num){
  var trs =  jQuery("table#ListaSeguimiento > tbody > tr");
console.log(num);
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

function DesplegableEmpresa(oForm){
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
function CambiarEmpresa(){
  document.forms.form1.method="post";
  document.forms.form1.action="Seguimiento.xsql";
	SubmitForm(document.forms.form1);
}

function CambiarEmpresaID(idEmpresa){
  document.forms.form1.elements.FIDEMPRESA.value = idEmpresa;
  CambiarEmpresa();
}

// Envía el formulario (llamada desde otra función)
function Enviar(){
	SubmitForm(document.forms.form1);
}

function Modificar(IDRegistro)
{
	document.forms['form1'].elements["ACCION"].value='MODIFICAR';

	document.forms['form1'].elements["PARAMETROS"].value=IDRegistro+'|'+document.forms['form1'].elements["IDCENTRO_"+IDRegistro].value+'|'+document.forms['form1'].elements["IDTIPO_"+IDRegistro].value+'|'+document.forms['form1'].elements["TEXTO_"+IDRegistro].value+'|'+document.forms['form1'].elements["VISIBILIDAD_"+IDRegistro].value;

	Enviar();
}

// Editar entrada de seguimiento
function Editar(IDRegistro){
  var d = new Date();

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
      var data = eval("(" + objeto + ")");

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

        // Publicamos los valores de los campos visibles del formulario
        jQuery('#ES_Centro').html(data.Seguimiento.Centro);
        jQuery.each(data.Seguimiento.Tipos, function(index, tipo){
          jQuery('#ES_IDTipo').append(jQuery("<option />").val(tipo.ID).text(tipo.Nombre));
        });
        jQuery('#ES_IDTipo').val(data.Seguimiento.IDTipo);
        jQuery('input[name="ES_IDVisibilidad"][value="' + data.Seguimiento.Visibilidad + '"]').prop('checked', true);
        jQuery('#ES_TEXTO').val(data.Seguimiento.Texto.replace(/<br>/gi,'\n'));

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
    msg += document.forms.mensajeJS.elements.FALTA_INFORMAR_DESCRIPCION.value+'\n';

  if(msg !== '')
    alert(msg);
  else{
    jQuery("#ACCION").val('MODIFICAR');
    var parametros = IDEntrada +
        '|' + IDCentro +
        '|' + jQuery('#ES_IDTipo').val() +
        '|' + Texto.replace(/<br \/>/gi,'\n') +
        '|' + jQuery('input[type="radio"][name="ES_IDVisibilidad"]:checked').val();

    jQuery("#PARAMETROS").val(parametros);

    Enviar();
  }
}

//	Borrar entrada de seguimiento
function Borrar(IDRegistro){
	document.forms.form1.elements.ACCION.value = 'BORRAR';
	document.forms.form1.elements.PARAMETROS.value = IDRegistro;

	Enviar();
}

// Abre el pop-up para generar nuevo seguimiento
function AbrirNuevo(){
  showTablaByID("NuevoSeguimientoWrap");
}


function nuevoSeguimiento(){
  var IDEmpresa     = jQuery("#NS_IDEmpresa").val();
  var IDCentro      = jQuery("#NS_IDCENTRO").val();
  var IDTipo        = jQuery("#NS_IDTIPO").val();
  var IDVisibilidad = jQuery("input[type='radio'][name='NS_IDVISIBILIDAD']:checked").val();
  var Texto         = jQuery("#NS_TEXTO").val();
  var msg = '';

  if(IDCentro != '-1' && Texto !== ''){
    document.forms.form1.elements.ACCION.value = 'NUEVA';
    document.forms.form1.elements.PARAMETROS.value = '|' + IDCentro +
        '|' + IDTipo +
        '|' + Texto.replace(/<br \/>/gi,'\n') +
        '|' + IDVisibilidad;

    Enviar();
  }else{
    if(Texto === ''){
      msg += textoObli + '\n';
    }
    if(IDCentro == '-1'){
      msg += crearCentro;
    }
    alert(msg);
  }
}


// 18may16	ET	LLamada al buscador
function Buscador()
{
	SubmitForm(document.forms.form1);
}




