//	JS para mantenimiento de noticias
//	Ultima revision 13jun19 12:30


function Enviar()
{
	//	Realizar accion
	document.forms['frmNoticias'].action="MantenimientoNoticiasSave.xsql";
	SubmitForm(document.forms['frmNoticias']);
}

function EstadoNoticia(IDNoticia, Accion)
{
	var form=document.forms['frmNoticias'];

	//	Copiamos los datos de la noticia seleccionada en los campos de intercambio
	document.getElementById('IDNOTICIA').value = IDNoticia;
	document.getElementById('FECHA').value = document.getElementById('FECHA_'+IDNoticia).value;
	document.getElementById('IDUSUARIO').value = document.getElementById('IDUSUARIO_'+IDNoticia).value;
	document.getElementById('TITULO').value = document.getElementById('TITULO_'+IDNoticia).value;
	document.getElementById('TEXTO').value = document.getElementById('TEXTO_'+IDNoticia).value;
	document.getElementById('PUBLICA').value = document.getElementById('PUBLICA_'+IDNoticia).value;
	document.getElementById('ESTADO').value = document.getElementById('ESTADO_'+IDNoticia).value;
	document.getElementById('DESTINATARIOS').value = document.getElementById('DESTINATARIOS_'+IDNoticia).value;




	//	Ejecutamos la accion
	if(Accion=='ACTIVAR')
		document.getElementById('ESTADO').value = '';
	else if(Accion=='OCULTAR')
		document.getElementById('ESTADO').value = 'O';
	else if(Accion=='BORRAR')
		document.getElementById('ESTADO').value = 'B';

	//	Realizar accion
	Enviar();
}

function Guardar()
{
	var form=document.forms['frmNoticias'];
	var MsgError='';
	var Destinatarios='';

	if(document.getElementById('NUEVA_PUBLICA').value =='NULL'){
		//	Construye la lista de destinatarios
		for(var i=1;i<=10;++i){
			if(form.elements['IDCENTRO'+i].value!='-1')
				Destinatarios=Destinatarios+form.elements['IDCENTRO'+i].value+'#';
		}
	}

	//	Validar datos introducidos
	if(document.getElementById('NUEVA_TITULO').value =='')
		MsgError=MsgError+'El título es obligatorio\n';
	if(document.getElementById('NUEVA_TEXTO').value =='')
		MsgError=MsgError+'El texto de la noticia es obligatorio\n';
	if(document.getElementById('NUEVA_PUBLICA').value =='0')
		MsgError=MsgError+'El destinatario de la noticia es obligatorio\n';
	if((document.getElementById('NUEVA_PUBLICA').value =='NULL')&&(Destinatarios==''))
		MsgError=MsgError+'Para la opción "Escoger empresas" debe seleccionar al menos una empresa en los desplegables\n';

	if( MsgError!='')
		alert(MsgError);
	else
	{

		//alert('Destinatarios: '+Destinatarios);

		//	Copiamos los datos de la noticia nueva
		//document.getElementById('IDNOTICIA').value = '';
		//document.getElementById('FECHA').value = '';
		document.getElementById('IDUSUARIO').value = '';
		document.getElementById('TITULO').value = document.getElementById('NUEVA_TITULO').value;
		document.getElementById('TEXTO').value = document.getElementById('NUEVA_TEXTO').value;
		document.getElementById('URL').value = document.getElementById('NUEVA_ENLACE_URL').value;
		document.getElementById('ANCHOR').value = document.getElementById('NUEVA_ENLACE_ANCHOR').value;
		document.getElementById('PUBLICA').value = document.getElementById('NUEVA_PUBLICA').value;
		document.getElementById('DESTINATARIOS').value = Destinatarios;
		document.getElementById('ESTADO').value = '';
/*
        //si hay imagenes
        if(hasFiles(form)){
                var target = 'uploadFrame';
                var action = 'http://' + location.hostname + '/cgi-bin/imageMVM.pl';
                var enctype = 'multipart/form-data';
                form.target = target;
                form.encoding = enctype;
                form.action = action;
                wait("Please wait...");
                form.submit();
                form_tmp = form;
                man_tmp = true;
                periodicTimer = 0;
                periodicUpdate();
        }else{
                Enviar();
        }
*/		
		Enviar();
	}

}


//	Si el destinatario son empresas individuales mostramos la tabla
function CambioDeDestinatario()
{
	if(document.getElementById('NUEVA_PUBLICA').value == 'NULL')
	{
		document.getElementById('ListaEmpresas').style.display='';
		document.getElementById('seleccionEmpresas').style.display='';
	}
	else
	{
		document.getElementById('ListaEmpresas').style.display='none';
		document.getElementById('seleccionEmpresas').style.display='none';
	}
}


//copiar datos de noticia en noticia nueva
function verNoticia(id)
{
	var form = document.forms['frmNoticias'];

	jQuery("#TituloTabla").html(form.elements['TITULO_'+id].value);

	form.elements['IDNOTICIA'].value = id;
	form.elements['FECHA'].value = form.elements['FECHA_'+id].value;
	form.elements['NUEVA_TITULO'].value = form.elements['TITULO_'+id].value;
	form.elements['NUEVA_TEXTO'].value = form.elements['TEXTO_'+id].value;
	form.elements['NUEVA_ENLACE_ANCHOR'].value = form.elements['ENLACE_ANCHOR_'+id].value;
	form.elements['NUEVA_ENLACE_URL'].value = form.elements['ENLACE_URL_'+id].value;
	form.elements['NUEVA_PUBLICA'].value = form.elements['PUBLICA_'+id].value;

	if (form.elements['DOC_ID_'+id].value!='')
	{
		var nombreDoc=form.elements['DOC_NOMBRE_'+id].value
		var	IDDoc=form.elements['DOC_ID_'+id].value
		var URLDoc=form.elements['DOC_URL_'+id].value

		jQuery("#inputFileDoc").hide();
		jQuery("#docSubido").html('<a target="_blank" href="http://www.newco.dev.br/Documentos/'+URLDoc+'">'+nombreDoc+'</a>');
		jQuery("#divDatosDocumento").show();

		//solodebug 
		debug('Editar: <a target="_blank" href="http://www.newco.dev.br/Documentos/'+URLDoc+'">'+nombreDoc+'</a>');

		jQuery("#IDDOCUMENTO").val(IDDoc);
	}
	else
	{
		jQuery("#inputFileDoc").show();
		jQuery("#docSubido").html('');
		jQuery("#divDatosDocumento").hide();
		jQuery("#IDDOCUMENTO").val('');
	}

}

//copiar datos de noticia en noticia nueva
function Limpiar(id)
{
	var form = document.forms['frmNoticias'];
	
	jQuery("#TituloTabla").html(str_NuevaNoticia);

	form.elements['IDNOTICIA'].value = '';
	form.elements['FECHA'].value = '';
	form.elements['NUEVA_TITULO'].value = '';
	form.elements['NUEVA_TEXTO'].value = '';
	form.elements['NUEVA_ENLACE_ANCHOR'].value = '';
	form.elements['NUEVA_ENLACE_URL'].value = '';
	form.elements['NUEVA_PUBLICA'].value = '';

	jQuery("#inputFileDoc").show();
	jQuery("#docSubido").html('');
	jQuery("#divDatosDocumento").hide();
	jQuery("#IDDOCUMENTO").val('');

}


function UsuariosNoticia(IDNoticia){
	MostrarPagPersonalizada('http://www.newco.dev.br/Noticias/UsuariosNoticia.xsql?IDNOTICIA=' + IDNoticia,'Usuarios Noticia',80,80,10,10);
}


//	Presenta la pagina con las selecciones
function MostrarSelecciones(){
    var Enlace	= 'http://www.newco.dev.br/Gestion/EIS/EISSelecciones.xsql';

    MostrarPagPersonalizada(Enlace, '_blank', 100, 80, 0, 10);
}
