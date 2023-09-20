//	JS para el listado/buscador de Licitaciones
//	Ultima revision ET 27oct20 11:42 Licitaciones_271020.js


//	3dic18	Funciones para paginación del listado
function Enviar(){
	var form=document.forms['Buscador'];
	SubmitForm(form);
}


function NuevaLicitacion(){
	window.open('http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql','_blank','scrollbars=yes');
}

function CambiarEstadoLicitacion(IDLic, IDEstado)
{
	var d = new Date();

	if (((IDEstado=='B')||(IDEstado=='SUS'))&&(jQuery('#FMOTIVOBORRAR_'+IDLic).val()=='-1'))
	{
		alert(strMotivoBorrar);
		jQuery('#FMOTIVOBORRAR_'+IDLic).show();
		return;
	}
	
	var IDMotivo=jQuery('#FMOTIVOBORRAR_'+IDLic).val();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/CambiarEstadoLicitacion.xsql',
		type:	"GET",
		data:	"ID_LIC="+IDLic+"&ID_ESTADO="+IDEstado+"&ID_MOTIVO="+IDMotivo+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.NuevoEstado.estado == 'OK'){
				 Enviar();
			}else{
				alert(errorNuevoEstadoLicitacion);
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}

function Orden(Campo)
{
	if (Campo==document.forms[0].elements['ORDEN'].value)
		document.forms[0].elements['SENTIDO'].value=(document.forms[0].elements['SENTIDO'].value=='DESC')?'ASC':'DESC';
	else
	{
		document.forms[0].elements['ORDEN'].value=Campo;
		if ((Campo=='TITULO')||(Campo=='COD')||(Campo=='ESTADO')||(Campo=='CLIENTE')||(Campo=='CENTROPEDIDO')||(Campo=='FECHADEC')||(Campo=='FECHALIC'))
			document.forms[0].elements['SENTIDO'].value='ASC';
		else
			document.forms[0].elements['SENTIDO'].value='DESC';
	}
	Enviar();
}

function VerPedidos(IDLicitacion)
{
	MostrarPagPersonalizada('http://www.newco.dev.br/Personal/BandejaTrabajo/AnalisisPedidos.xsql?IDLICITACION='+IDLicitacion,'HistoricoPedidos',90,90,10,10);
}
