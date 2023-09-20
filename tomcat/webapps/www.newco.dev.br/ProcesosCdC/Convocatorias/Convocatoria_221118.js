//	JS asociado al mantenimiento convocatoria Convocatoria_221118.js
//	Ultima revision: ET 22nov18 11:09

//	Inicializa algunos campos
function Inicializa()
{
	jQuery("#btnIncluir").hide();
}

//	Inicializa algunos campos
function cbIDProveedorChange()
{
	var IDProveedor=document.forms["frmConv"].elements['IDPROVEEDOR'].value;
	if (IDProveedor=='-1')
	 
		jQuery("#btnIncluir").hide();
	else
		jQuery("#btnIncluir").show();
}

function Enviar(){
	var form=document.forms["frmConv"];

	SubmitForm(form);
}


//	Guarda los cambios en la convocatoria
function Guardar()
{
	document.forms["frmConv"].elements['ACCION'].value='GUARDAR';
	Enviar();
}

//	Muestra la página por defecto para Convocatoria Especial
function VerConvocatoriaEspecial()
{
	var IDConvocatoria=document.forms["frmConv"].elements['LIC_CONV_ID'].value;
	document.location='http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/Proveedores.xsql?FIDCONVOCATORIA='+IDConvocatoria; 
}

//	Muestra la página por defecto para Convocatoria Normal
function VerConvocatoriaNormal()
{
	var IDConvocatoria=document.forms["frmConv"].elements['LIC_CONV_ID'].value;
	document.location='http://www.newco.dev.br/ProcesosCdC/Convocatorias/ProveedorYOfertas.xsql?FIDCONVOCATORIA='+IDConvocatoria;
}


//	Incluye un proveedor en todas las licitaciones
function IncluirProveedor()
{
	var IDProveedor=document.forms["frmConv"].elements['IDPROVEEDOR'].value;

	document.forms["frmConv"].elements['ACCION'].value='INCLUIR';
	document.forms["frmConv"].elements['PARAMETROS'].value=IDProveedor;
	
	Enviar();
}

//	Incluye un proveedor en todas las licitaciones
function ProveedorATodas(IDProveedor)
{
	document.forms["frmConv"].elements['ACCION'].value='INCLUIR';
	document.forms["frmConv"].elements['PARAMETROS'].value=IDProveedor;
	
	Enviar();
}

//	Suspende un proveedor en todas las licitaciones
function SuspenderProveedor(IDProveedor)
{
	document.forms["frmConv"].elements['ACCION'].value='SUSPENDER';
	document.forms["frmConv"].elements['PARAMETROS'].value=IDProveedor;
	
	Enviar();
}

//	Borrar un proveedor en todas las licitaciones (debe estar previamente suspendido)
function BorrarProveedor(IDProveedor)
{
	if (confirm(strEstaSeguroDeBorrar))
	{
		document.forms["frmConv"].elements['ACCION'].value='BORRAR';
		document.forms["frmConv"].elements['PARAMETROS'].value=IDProveedor;
	
		Enviar();
	}
}

//	Recupera un proveedor en todas las licitaciones
function RecuperarProveedor(IDProveedor)
{
	document.forms["frmConv"].elements['ACCION'].value='RECUPERAR';
	document.forms["frmConv"].elements['PARAMETROS'].value=IDProveedor;
	
	Enviar();
}

