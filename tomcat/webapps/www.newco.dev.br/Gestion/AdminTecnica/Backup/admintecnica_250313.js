//	Ultima revisi�n: 7mar13: copiar derechos generales de usuario

//	Env�a el formulario
function Enviar()
{
	//alert(document.forms[0].elements["ACCION"].value+':'+document.forms[0].elements["PARAMETROS"].value);
	SubmitForm(document.forms[0]);
}

//	Asigna acci�n y env�a formulario
function Accion(Tipo)
{
	document.forms[0].elements["ACCION"].value=Tipo;
	document.forms[0].elements["PARAMETROS"].value='';
	
	Enviar();
}

//	Busca ID, asigna acci�n y env�a formulario
function AsociarEmpresa()
{
	var IDEmpresa=document.forms[0].elements["IDCLIENTESINCATALOGO"].value;
	document.forms[0].elements["ACCION"].value='ASOCIAR';
	document.forms[0].elements["PARAMETROS"].value=IDEmpresa;
	
	if (IDEmpresa!='-1') Enviar()
	else alert('Falta seleccionar la empresa.');
}

//	Busca ID, asigna acci�n y env�a formulario
function OcultarProductosNoCompradosAEmpresa()
{
	var IDEmpresa=document.forms[0].elements["IDCLIENTE"].value;
	document.forms[0].elements["ACCION"].value='OCULTARAEMPRESA';
	document.forms[0].elements["PARAMETROS"].value=IDEmpresa;
	
	if (IDEmpresa!='-1') Enviar()
	else alert('Falta seleccionar la empresa.');
}

//	Busca ID, asigna acci�n y env�a formulario
function OcultarProductosNoCompradosAUsuario()
{
	var IDUsuario=document.forms[0].elements["IDUSUARIOOCULTAR"].value;
	document.forms[0].elements["ACCION"].value='OCULTARAUSUARIO';
	document.forms[0].elements["PARAMETROS"].value=IDUsuario;
	
	if (IDUsuario!='') Enviar()
	else alert('Falta seleccionar el usuario.');
}

//	Busca ID, asigna acci�n y env�a formulario
function DesbloquearProveedor()
{
	var IDEmpresa=document.forms[0].elements["IDPROVEEDORESBLOQUEADOS"].value;
	document.forms[0].elements["ACCION"].value='DESBLOQUEAR';
	document.forms[0].elements["PARAMETROS"].value=IDEmpresa;
	
	if (IDEmpresa!='-1') Enviar()
	else alert('Falta seleccionar la empresa.');
}

//	Busca ID, asigna acci�n y env�a formulario
function BloquearProveedor()
{
	var IDEmpresa=document.forms[0].elements["IDPROVEEDORESDESBLOQUEADOS"].value;
	document.forms[0].elements["ACCION"].value='BLOQUEAR';
	document.forms[0].elements["PARAMETROS"].value=IDEmpresa;
	
	if (IDEmpresa!='-1') Enviar()
	else alert('Falta seleccionar la empresa.');
}

//	Busca consulta, asigna acci�n y env�a formulario
function SQLSelect()
{
	var SQL=document.forms[0].elements["SQL_SELECT"].value;
	document.forms[0].elements["ACCION"].value='SELECT';
	document.forms[0].elements["PARAMETROS"].value=SQL;
	
	if (SQL!='') Enviar()
	else alert('Falta introducir la consulta.');
}

//	Busca consulta, asigna acci�n y env�a formulario
function SQLUpdate()
{
	var SQL=document.forms[0].elements["SQL_UPDATE"].value;
	document.forms[0].elements["ACCION"].value='UPDATE';
	document.forms[0].elements["PARAMETROS"].value=SQL;
	
	if (SQL!='') Enviar()
	else alert('Falta introducir la consulta.');
}

//	Busca datos consulta, asigna acci�n y env�a formulario
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

//	Busca datos consulta, asigna acci�n y env�a formulario
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

//	Copiar derechos men�s
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



//	Mata la sesi�n
function MatarSesion()
{
	var IDSesion=document.forms[0].elements["IDSESION"].value;
	document.forms[0].elements["ACCION"].value='MATARSESION';
	document.forms[0].elements["PARAMETROS"].value=IDSesion;
	
	if (IDSesion!='-1') Enviar()
	else alert('Falta informar la sesi�n.');
}












