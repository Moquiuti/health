//	�ltima revisi�n: 18abr12

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
function BorrarSinonimo(Nombre, Sinonimo)
{
	document.forms[0].elements["ACCION"].value='BORRAR';
	document.forms[0].elements["PARAMETROS"].value=Nombre+'|'+Sinonimo;
	
	if ((Nombre!='') && (Sinonimo!='')) Enviar()
	else alert('Falta informar los sin�nimos.');
}


//	Busca ID, asigna acci�n y env�a formulario
function InsertarSinonimo()
{
	document.forms[0].elements["ACCION"].value='NUEVO';
	document.forms[0].elements["PARAMETROS"].value=document.forms[0].elements["NOMBRE"].value+'|'+document.forms[0].elements["SINONIMO"].value;
	
	if ((document.forms[0].elements["NOMBRE"].value!='') && (document.forms[0].elements["SINONIMO"].value!='')) Enviar()
	else alert('Falta informar los sin�nimos.');
}















