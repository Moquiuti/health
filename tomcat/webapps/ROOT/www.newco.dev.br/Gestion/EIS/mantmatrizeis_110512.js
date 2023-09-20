//	ET	Ultima revisión: 11may12

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
function BorrarIndicador(IDIndicador)
{
	document.forms[0].elements["ACCION"].value='BORRAR';
	document.forms[0].elements["PARAMETROS"].value=IDIndicador;
	
	if (IDIndicador!='') Enviar()
	else alert('Falta informar el ID del indicador.');
}


//	Busca ID, asigna acción y envía formulario
function InsertarIndicador()
{
	document.forms[0].elements["ACCION"].value='NUEVO';
	document.forms[0].elements["PARAMETROS"].value=document.forms[0].elements["ID"].value
							+'·'+document.forms[0].elements["ORDEN"].value
							+'·'+document.forms[0].elements["NOMBRE"].value
							+'·'+document.forms[0].elements["FILTRO_PROVEEDOR"].value
							+'·'+document.forms[0].elements["FILTRO_FAMILIA"].value
							+'·'+document.forms[0].elements["FILTRO_TEXTO"].value;
	
	if ((document.forms[0].elements["ID"].value!='') && (document.forms[0].elements["NOMBRE"].value!='')
		&& ((document.forms[0].elements["FILTRO_PROVEEDOR"].value!='') || (document.forms[0].elements["FILTRO_FAMILIA"].value!='') || (document.forms[0].elements["FILTRO_TEXTO"].value!=''))
		) Enviar()
	else alert('Falta informar el ID o el nombre o el filtro del indicador.');
}



//	Busca ID, asigna acción y envía formulario
function ModificarIndicador(IDIndicador)
{
	document.forms[0].elements["ACCION"].value='MODIFICAR';
	document.forms[0].elements["PARAMETROS"].value=IDIndicador
							+'·'+document.forms[0].elements["ORDEN_"+IDIndicador].value
							+'·'+document.forms[0].elements["NOMBRE_"+IDIndicador].value
							+'·'+document.forms[0].elements["FILTRO_PROVEEDOR_"+IDIndicador].value
							+'·'+document.forms[0].elements["FILTRO_FAMILIA_"+IDIndicador].value
							+'·'+document.forms[0].elements["FILTRO_TEXTO_"+IDIndicador].value;
	
	if ((IDIndicador!='') && (document.forms[0].elements["NOMBRE_"+IDIndicador].value!='')
		&& ((document.forms[0].elements["FILTRO_PROVEEDOR_"+IDIndicador].value!='') || (document.forms[0].elements["FILTRO_FAMILIA_"+IDIndicador].value!='') || (document.forms[0].elements["FILTRO_TEXTO_"+IDIndicador].value!=''))
		) Enviar()
	else alert('Falta informar el ID o el nombre o el filtro del indicador.');
}














