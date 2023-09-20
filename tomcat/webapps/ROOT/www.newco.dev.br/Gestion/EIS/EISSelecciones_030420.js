//	JS Selecciones/agrupaciones para consultas
//	Ultima revisión: ET 1abr20 16:00 EISSelecciones_010420.js

//	24may19 Cambio en el desplegable de la empresa
function CambioEmpresa()
{
	EnviaForm('CAMBIOEMPRESA');
}

function CambioCategoria()
{
	EnviaForm('CAMBIOCATEGORIA');
}

function EnviaForm(Accion)
{
	document.forms['Selecciones'].elements['ACCION'].value=Accion;
	document.forms['Selecciones'].elements['IDEMPRESA'].value = document.forms['Selecciones'].elements['IDEMPRESALISTA'].value;
	SubmitForm(document.forms[0]);
}


function BorrarSeleccion(idSeleccion)
{
	if (confirm(strAvisoBorrar))
	{
		document.forms[0].elements['ACCION'].value='BORRAR';
		document.forms[0].elements['IDSELECCION'].value=idSeleccion;
		SubmitForm(document.forms[0]);
	}
}


//	Abre la página de mantenimiento de la selección correspondiente
function Seleccion(idSeleccion)
{
	window.location="http://www.newco.dev.br/Gestion/EIS/EISSeleccion.xsql?IDSELECCION="+idSeleccion;	
}

//	Abre la página de mantenimiento de la selección correspondiente
function NuevaSeleccion()
{
	window.location="http://www.newco.dev.br/Gestion/EIS/EISSeleccion.xsql";	
}

function DescargarExcel(){
	var form=document.forms[0];
    var cadEmpresa='';
	
	if (document.forms['Selecciones'].elements['ADMINMVM'].value=='S')
	{
		cadEmpresa='?IDEMPRESA='+document.forms['Selecciones'].elements['IDEMPRESALISTA'].value;
	}
	
	
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'EISSeleccionesExcel.xsql'+cadEmpresa,
		type:	"GET",
		data:	"d="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj)
		{
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto)
		{
			var data = eval("(" + objeto + ")");

            if(data.estado == 'ok') window.location='http://www.newco.dev.br/Descargas/'+data.url;
            else alert('Se ha producido un error. No se puede descargar el fichero.');
        }
	});
}



