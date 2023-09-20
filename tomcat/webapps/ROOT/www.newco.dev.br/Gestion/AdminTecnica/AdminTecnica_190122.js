//	JS para la administración avanzada
//	Ultima revisión: ET 19ene22 09:00 AdminTecnica_190122.js

//	19ene22 Procesos a ejecutar tras cargar la pagina
function onLoadBody()
{
	//	Comprobamos si hay que activar el temporizador
	var periodo=document.forms[0].elements["PERIODO"].value;
	//debug("onLoadBody. Periodo:"+periodo);
	if (periodo!='0') ActualizacionPeriodica();
}



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

//	Repite la peticion regularmente
function ActualizacionPeriodica()
{
	setTimeout(Enviar,parseFloat(document.forms[0].elements["PERIODO"].value*60000));
}


//	Busca ID, asigna acción y envía formulario
function AsociarEmpresa()
{
	var IDEmpresa=document.forms[0].elements["IDCLIENTESINCATALOGO"].value;
	var IDCatalogo=document.forms[0].elements["IDCATALOGOPADRE"].value;
	document.forms[0].elements["ACCION"].value='ASOCIAR';
	document.forms[0].elements["PARAMETROS"].value=IDEmpresa+'|'+IDCatalogo;
	
	if ((IDEmpresa!='-1')&&(IDCatalogo!='-1')) Enviar()
	else alert('Falta seleccionar la empresa o el catálogo.');
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

//	Busca ID, asigna acción y envía formulario
function OcultarProveedorAUsuario()
{
	var Parametros=document.forms[0].elements["IDUSUARIOOCULTARPROVEEDOR"].value+'|'+document.forms[0].elements["IDPROVEEDORES"].value;
	document.forms[0].elements["ACCION"].value='OCULTARPROVEEDORAUSUARIO';
	document.forms[0].elements["PARAMETROS"].value=Parametros;
	
	if ((document.forms[0].elements["IDPROVEEDORES"].value!='-1')&&(document.forms[0].elements["IDUSUARIOOCULTARPROVEEDOR"].value!='')) Enviar()
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

//	Mata todas las sesiones antiguas
function MatarSesionesAntiguas()
{
	document.forms[0].elements["ACCION"].value='MATARANTIGUAS';
	Enviar()
}

//	Mata todas las sesiones antiguas
function MatarTodasSesiones()
{
	document.forms[0].elements["ACCION"].value='MATARTODAS';
	Enviar()
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
	var nuevoTexto = codificacionAjax(jQuery("#input_" + IDFichero + "_" + IDLinea).val());
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


// 8ago16	Funcion que abre la OC en el formato que corresponda
function MostrarOC(IDFichero){
	MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/AdminTecnica/ExportarFicheroOC.xsql?IDFICHERO='+IDFichero,'',100,100,0,0);
}


// 22ago16	Funcion que descarga la OC en el formato que correspondam creado a partir de DescargarExcel
function DescargarOC(IDFichero){
	var d = new Date();

	//alert('Detectar version de IE');
	if (navigator.userAgent.indexOf('MSIE') != -1)
	{
 		var detectIEregexp = /MSIE (\d+\.\d+);/ 
	}
	else { 
 		var detectIEregexp = /Trident.*rv[ :]*(\d+\.\d+)/ 
	}
	if (detectIEregexp.test(navigator.userAgent)){ 
 		var ieversion=new Number(RegExp.$1)
	}


	jQuery.ajax({
		url: 'http://www.newco.dev.br/Gestion/AdminTecnica/DescargaOC.xsql',
		data: "IDFICHERO="+IDFichero+"&_="+d.getTime(),
	type: "GET",
	contentType: "application/xhtml+xml",
	error: function(objeto, quepaso, otroobj){
	  alert('error'+quepaso+' '+otroobj+''+objeto);
	},
	success: function(objeto){
	
		var data = eval("(" + objeto + ")");

		var urlfichero='http://www.newco.dev.br/Descargas/'+data.url;

		if(data.estado == 'ok')
		{

			// Check for the various File API support.
			if (window.File && window.FileReader && window.FileList && window.Blob) {
				
				jQuery.get(urlfichero, function(fileContent) {
					

					var pom = document.createElement('a');
					
					// PS 26ago16 cambiar extension txt por xml
    				//pom.setAttribute('href', 'data:application/xhtml+xml;charset=utf-8,' + encodeURIComponent(fileContent));			    				
    				var strdataurl = data.url;
    				strdataurl=strdataurl.replace(".txt",".xml");
    				//alert('strdataurl: '+strdataurl);
					pom.setAttribute('href', 'data:text/html;charset=utf-8,' + encodeURIComponent(fileContent));
					//alert('fileContent: '+fileContent);
    				pom.setAttribute('download', strdataurl);

				// descargar para IE 11 o superior
				if (ieversion>=11) {
					//alert('IE11');
					//alert('strdataurl:'+strdataurl);
					//alert('fileContent:'+fileContent);
    				var blobObject = new Blob([fileContent]);
    				window.navigator.msSaveBlob(blobObject, strdataurl);
    				blobObject = new Blob(fileContent);
    				window.alert(blobObject);
    				window.navigator.msSaveOrOpenBlob(blobObject, strdataurl);
					//alert('blobObject: '+blobObject);
				}
				// descargar para IE 10 o inferior
				if (ieversion<=10) {
					alert('otros IE');
				//alert('strdataurl:'+strdataurl);
				//alert('fileContent:'+fileContent);
				}

    				if (document.createEvent) {
        				var event = document.createEvent('MouseEvents');
        				event.initEvent('click', true, true);
        				pom.dispatchEvent(event);
    				}
    				else {
        				pom.click();
    				}
					
				});

			} else {
				//	Alguna de las APIs necesarias para la descarga no está soportada, por lo que abrimos directamente la página
				//alert('MostrarPagPersonalizada: ');
				// Para IE < 11: muestra ventana con toolbar y menú PS 29ago16
				MostrarXML(urlfichero);
				//MostrarPagPersonalizada(urlfichero,'XML',100,100,0,0);
			}
		}
		else{
			alert('Se ha producido un error. No se puede descargar el fichero '+urlfichero+'.');
		}
	}
  });
}

function MostrarXML(urlfichero){

	var url=urlfichero;
	var ventana="toolbar=1,location=1,resizable=1,width=600,height=600,top=0,left=0";
	win=window.open(url,"",ventana);

}



