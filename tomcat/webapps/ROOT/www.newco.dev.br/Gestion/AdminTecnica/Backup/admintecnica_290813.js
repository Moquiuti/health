//	Ultima revisión: 29ago13: mantenimiento ficheros de integración

//	Envía el formulario
function Enviar()
{
	//alert(document.forms[0].elements["ACCION"].value+':'+document.forms[0].elements["PARAMETROS"].value);
	SubmitForm(document.forms[0]);
}

//	Asigna acción y envía formulario
function Accion(Tipo)
{
	document.forms[0].elements["ACCION"].value=Tipo;
	document.forms[0].elements["PARAMETROS"].value='';
	
	Enviar();
}

//	Busca ID, asigna acción y envía formulario
function AsociarEmpresa()
{
	var IDEmpresa=document.forms[0].elements["IDCLIENTESINCATALOGO"].value;
	document.forms[0].elements["ACCION"].value='ASOCIAR';
	document.forms[0].elements["PARAMETROS"].value=IDEmpresa;
	
	if (IDEmpresa!='-1') Enviar()
	else alert('Falta seleccionar la empresa.');
}

//	Busca ID, asigna acción y envía formulario
function OcultarProductosNoCompradosAEmpresa()
{
	var IDEmpresa=document.forms[0].elements["IDCLIENTE"].value;
	document.forms[0].elements["ACCION"].value='OCULTARAEMPRESA';
	document.forms[0].elements["PARAMETROS"].value=IDEmpresa;
	
	if (IDEmpresa!='-1') Enviar()
	else alert('Falta seleccionar la empresa.');
}

//	Busca ID, asigna acción y envía formulario
function DerechosProductosUsuario(Param)
{
	var IDUsuario=document.forms[0].elements["IDUSUARIOOCULTAR"].value;
	document.forms[0].elements["ACCION"].value=Param;
	document.forms[0].elements["PARAMETROS"].value=IDUsuario;
	
	if (IDUsuario!='') Enviar()
	else alert('Falta seleccionar el usuario.');
}

//	Busca ID, asigna acción y envía formulario
function DesbloquearProveedor()
{
	var IDEmpresa=document.forms[0].elements["IDPROVEEDORESBLOQUEADOS"].value;
	document.forms[0].elements["ACCION"].value='DESBLOQUEAR';
	document.forms[0].elements["PARAMETROS"].value=IDEmpresa;
	
	if (IDEmpresa!='-1') Enviar()
	else alert('Falta seleccionar la empresa.');
}

//	Busca ID, asigna acción y envía formulario
function BloquearProveedor()
{
	var IDEmpresa=document.forms[0].elements["IDPROVEEDORESDESBLOQUEADOS"].value;
	document.forms[0].elements["ACCION"].value='BLOQUEAR';
	document.forms[0].elements["PARAMETROS"].value=IDEmpresa;
	
	if (IDEmpresa!='-1') Enviar()
	else alert('Falta seleccionar la empresa.');
}

//	Busca consulta, asigna acción y envía formulario
function SQLSelect()
{
	var SQL=document.forms[0].elements["SQL_SELECT"].value;
	document.forms[0].elements["ACCION"].value='SELECT';
	document.forms[0].elements["PARAMETROS"].value=SQL;
	
	if (SQL!='') Enviar()
	else alert('Falta introducir la consulta.');
}

//	Busca consulta, asigna acción y envía formulario
function SQLUpdate()
{
	var SQL=document.forms[0].elements["SQL_UPDATE"].value;
	document.forms[0].elements["ACCION"].value='UPDATE';
	document.forms[0].elements["PARAMETROS"].value=SQL;
	
	if (SQL!='') Enviar()
	else alert('Falta introducir la consulta.');
}

//	Busca datos consulta, asigna acción y envía formulario
function ConsultarLogs()
{
	var Parametros=document.forms[0].elements["TIPOLOG"].value
		+'|'+document.forms[0].elements["PLAZO"].value
		+'|'+document.forms[0].elements["LINEAS"].value
		+'|'+document.forms[0].elements["FILTRO"].value;
	document.forms[0].elements["ACCION"].value='LOGS';
	document.forms[0].elements["PARAMETROS"].value=Parametros;

	Enviar();
}

//	Busca datos consulta, asigna acción y envía formulario
function BorrarLogs()
{
	var Parametros=document.forms[0].elements["TIPOLOG"].value
		+'|'+document.forms[0].elements["PLAZO"].value
		+'|'+document.forms[0].elements["LINEAS"].value
		+'|'+document.forms[0].elements["FILTRO"].value;
	document.forms[0].elements["ACCION"].value='BORRARLOGS';
	document.forms[0].elements["PARAMETROS"].value=Parametros;

	Enviar();
}

//	Copiar derechos menús
function CopiarDerechosMenu()
{
	var Parametros=document.forms[0].elements["CDM_ORIGEN"].value
		+'|'+document.forms[0].elements["CDM_DESTINO"].value;
	document.forms[0].elements["ACCION"].value='COPIARMENUS';
	document.forms[0].elements["PARAMETROS"].value=Parametros;

	Enviar();
}

//	Copiar derechos carpetas y plantillas
function CopiarDerechosCarpetasYPlantillas()
{
	var Parametros=document.forms[0].elements["CDP_ORIGEN"].value
		+'|'+document.forms[0].elements["CDP_DESTINO"].value;
	document.forms[0].elements["ACCION"].value='COPIARPLANTILLAS';
	document.forms[0].elements["PARAMETROS"].value=Parametros;

	Enviar();
}


//	Copiar derechos generales
function CopiarDerechosGenerales()
{
	var Parametros=document.forms[0].elements["CDG_ORIGEN"].value
		+'|'+document.forms[0].elements["CDG_DESTINO"].value;
	document.forms[0].elements["ACCION"].value='COPIARDERECHOS';
	document.forms[0].elements["PARAMETROS"].value=Parametros;

	Enviar();
}



//	Mata la sesión
function MatarSesion()
{
	var IDSesion=document.forms[0].elements["IDSESION"].value;
	document.forms[0].elements["ACCION"].value='MATARSESION';
	document.forms[0].elements["PARAMETROS"].value=IDSesion;
	
	if (IDSesion!='-1') Enviar()
	else alert('Falta informar la sesión.');
}



//	Vuelve a lanzar la ejecución de un fichero de integración
function EjecutarFichero(IDFichero)
{
	document.forms[0].elements["ACCION"].value='INT_EJECUTAR';
	document.forms[0].elements["PARAMETROS"].value=IDFichero;

	Enviar();
//	Accion('INT_CONSULTA');
//	setTimeout(function(){
//		window.location.reload(true);
//	}, 500);
	
}

//	Fuerza la marca de OK en un fichero de integración
function OkManualFichero(IDFichero)
{
	document.forms[0].elements["ACCION"].value='INT_OKMANUAL';
	document.forms[0].elements["PARAMETROS"].value=IDFichero;

	Enviar();
//	Accion('INT_CONSULTA');
//	setTimeout(function(){
//		window.location.reload(true);
//	}, 500);
}

//	Abre una nueva pagina para editar ficheros de integracion 
function EditarFichero(IDFichero)
{
	MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/AdminTecnica/MantFicheroInt.xsql?INTF_ID='+IDFichero,'MantPedido',100,100,0,0);
}

//	Abre un pop-up con el parametro de la funcion
function verComentarios(txt){
	alert(txt);
}

//	Marca una linea de la tabla INT_LINEASFICHEROS como comentario
function marcarComentarios(IDFichero,IDLinea){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/AdminTecnica/MarcarComentario.xsql',
		type:	"GET",
		data:	"INTL_IDFICHERO="+IDFichero+"&INTL_LINEA="+IDLinea+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.MarcarComentario.estado == 'OK'){
				if(data.MarcarComentario.id == IDLinea)
					window.location.reload(true);
                        }else{
				alert('Error');
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}

//	Modifica una linea de productos de la tabla INT_LINEASFICHEROS
function modificarLinea(IDFichero,IDLinea){
	var nuevoTexto = jQuery("#input_" + IDFichero + "_" + IDLinea).val();
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/AdminTecnica/ModificarLinea.xsql',
		type:	"GET",
		data:	"INTL_IDFICHERO="+IDFichero+"&INTL_LINEA="+IDLinea+"&NUEVO_TEXTO="+nuevoTexto+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.ModificarLinea.estado == 'OK'){
				if(data.ModificarLinea.id == IDLinea){
					alert(linea_fichero_actualizada);
					window.location.reload(true);
				}
                        }else{
				alert('Error');
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}
