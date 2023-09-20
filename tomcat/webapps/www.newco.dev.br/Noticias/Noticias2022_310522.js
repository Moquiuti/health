//	JS para mantenimiento de noticias
//	Ultima revision ET 1jun22 09:25 Noticias_310522.js

function Enviar()
{
	//alert('Enviar');

	//	Realizar accion
	document.forms['frmNoticias'].elements['ACCION'].value='GUARDAR';
	document.forms['frmNoticias'].action="Noticias2022.xsql";
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
	//document.getElementById('PUBLICA').value = document.getElementById('PUBLICA_'+IDNoticia).value;
	document.getElementById('ESTADO').value = document.getElementById('ESTADO_'+IDNoticia).value;
	//document.getElementById('DESTINATARIOS').value = document.getElementById('DESTINATARIOS_'+IDNoticia).value;
	document.getElementById('IDSELECCION').value = document.getElementById('IDSELECCION_'+IDNoticia).value;


	if (document.getElementById('DESTACADA_'+IDNoticia).value=='S')
		document.getElementById('CHK_DESTACADA').checked=true;
	else
		document.getElementById('CHK_DESTACADA').checked=false;


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

	/*if(document.getElementById('NUEVA_PUBLICA').value =='NULL'){
		//	Construye la lista de destinatarios
		for(var i=1;i<=10;++i){
			if(form.elements['IDCENTRO'+i].value!='-1')
				Destinatarios=Destinatarios+form.elements['IDCENTRO'+i].value+'#';
		}
	}*/

	//	Validar datos introducidos
	if(document.getElementById('NUEVA_TITULO').value =='')
		MsgError=MsgError+'El t�tulo es obligatorio\n';
	if(document.getElementById('NUEVA_TEXTO').value =='')
		MsgError=MsgError+'El texto de la noticia es obligatorio\n';

/*	if(document.getElementById('NUEVA_PUBLICA').value =='0')
		MsgError=MsgError+'El destinatario de la noticia es obligatorio\n';
	if((document.getElementById('NUEVA_PUBLICA').value =='NULL')&&(Destinatarios==''))
		MsgError=MsgError+'Para la opci�n "Escoger empresas" debe seleccionar al menos una empresa en los desplegables\n';*/
	
	if(document.getElementById('IDSELECCION').value =='-1')
		MsgError=MsgError+'El destinatario de la noticia es obligatorio\n';
	
	if( MsgError!='')
		alert(MsgError);
	else
	{

		//alert('Destinatarios: '+Destinatarios);

		//	Copiamos los datos de la noticia nueva
		document.getElementById('IDUSUARIO').value = '';
		document.getElementById('TITULO').value = document.getElementById('NUEVA_TITULO').value;
		document.getElementById('TEXTO').value = document.getElementById('NUEVA_TEXTO').value;
		document.getElementById('URL').value = document.getElementById('NUEVA_ENLACE_URL').value;
		document.getElementById('ANCHOR').value = document.getElementById('NUEVA_ENLACE_ANCHOR').value;
		document.getElementById('ESTADO').value = '';

		if (document.getElementById('CHK_DESTACADA').checked)
			document.getElementById('DESTACADA').value = 'S';
		else
			document.getElementById('DESTACADA').value = 'N';
		
		Enviar();
	}

}


//	Si el destinatario son empresas individuales mostramos la tabla
/*
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
*/

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
	//form.elements['NUEVA_PUBLICA'].value = form.elements['PUBLICA_'+id].value;
	
	
	if ((form.elements['IDSELECCION_'+id].value=='-1')||(form.elements['IDSELECCION_'+id].value=='TODOS')||(form.elements['IDSELECCION_'+id].value=='COMPRADOR')||(form.elements['IDSELECCION_'+id].value=='VENDEDOR'))
		form.elements['IDSELECCION'].value = form.elements['IDSELECCION_'+id].value;
	else
		form.elements['IDSELECCION'].value = 'SEL_'+form.elements['IDSELECCION_'+id].value;
	

	//31may22 Recuperamos la marca de "DESTACADA"
	if (document.getElementById('DESTACADA_'+id).value=='S')
		document.getElementById('CHK_DESTACADA').checked=true;
	else
		document.getElementById('CHK_DESTACADA').checked=false;

	if (form.elements['DOC_ID_'+id].value!='')
	{
		var nombreDoc=form.elements['DOC_NOMBRE_'+id].value
		var	IDDoc=form.elements['DOC_ID_'+id].value
		var URLDoc=form.elements['DOC_URL_'+id].value

		jQuery("#inputFileDoc").hide();
		jQuery("#docSubido").html('<a target="_blank" href="http://www.newco.dev.br/Documentos/'+URLDoc+'">'+nombreDoc+'</a>');
		jQuery("#divDatosDocumento").show();

		//solodebug debug('Editar: <a target="_blank" href="http://www.newco.dev.br/Documentos/'+URLDoc+'">'+nombreDoc+'</a>');

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
	form.elements['CHK_DESTACADA'].checked = false;
	form.elements['DESTACADA'].value = '';
	//form.elements['NUEVA_PUBLICA'].value = '';

	jQuery("#inputFileDoc").show();
	jQuery("#docSubido").html('');
	jQuery("#divDatosDocumento").hide();
	jQuery("#IDDOCUMENTO").val('');

}


function UsuariosNoticia(IDNoticia){
	//1jun22 MostrarPagPersonalizada('http://www.newco.dev.br/Noticias/UsuariosNoticia2022.xsql?IDNOTICIA=' + IDNoticia,'Usuarios Noticia',80,80,10,10);
	document.location='http://www.newco.dev.br/Noticias/UsuariosNoticia2022.xsql?IDNOTICIA=' + IDNoticia;
}


/*	1jun22
//	Presenta la pagina con las selecciones
function MostrarSelecciones(){
    var Enlace	= 'http://www.newco.dev.br/Gestion/EIS/EISSelecciones2022.xsql';
    MostrarPagPersonalizada(Enlace, '_blank', 100, 80, 0, 10);
}*/
