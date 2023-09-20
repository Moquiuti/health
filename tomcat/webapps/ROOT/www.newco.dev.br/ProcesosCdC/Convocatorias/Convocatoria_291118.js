//	JS asociado al mantenimiento convocatoria Convocatoria_291118.js
//	Ultima revision: ET 29nov18 13:18

//	Inicializa algunos campos
function Inicializa()
{
	jQuery("#btnIncluirProv").hide();
	jQuery("#btnIncluirLic").hide();
	jQuery("#divProveedores").hide();
	jQuery("#aLicitaciones").hide();

	//	Activamos la primera opción de menú
	activarPestanna('pes_Licitaciones');

	// Codigo javascript para mostrar/ocultar tablas cuando se clica en pestañas
	jQuery("#pes_Licitaciones").click(function(){
		activarPestanna('pes_Licitaciones');
	});
	jQuery("#pes_Proveedores").click(function(){
		activarPestanna('pes_Proveedores');
	});

}


//	Marca pestaña pulsada + activa el div con el formulario según pestaña activa
function activarPestanna(pestanna)
{	
	//solodebug console.log(pestanna+'.click(function(): activar div_'+pestanna);

	//	16oct17	Marcamos la pestaña seleccionada
	jQuery("a.MenuLic").css('background','#F0F0F0');
	jQuery("a.MenuLic").css('color','#555555');
	jQuery("#"+pestanna).css('background','#3b569b');
	jQuery("#"+pestanna).css('color','#D6D6D6');


	jQuery(".divForm").hide();
	jQuery("#div_"+pestanna).show();
}


//	Muestra div de proveedores
function VerProveedores()
{
	jQuery("#divProveedores").show();
	jQuery("#divLicitaciones").hide();

	jQuery("#aProveedores").hide();
	jQuery("#aLicitaciones").show();
}

//	Muestra div de licitaciones
function VerLicitaciones()
{
	jQuery("#divProveedores").hide();
	jQuery("#divLicitaciones").show();

	jQuery("#aProveedores").show();
	jQuery("#aLicitaciones").hide();
}

//	Inicializa algunos campos
function cbIDProveedorChange()
{
	var IDProveedor=document.forms["frmConv"].elements['IDPROVEEDOR'].value;
	if (IDProveedor=='-1')
		jQuery("#btnIncluirProv").hide();
	else
		jQuery("#btnIncluirProv").show();
}

//	Inicializa algunos campos
function cbIDLicitacionChange()
{
	var IDLicitacion=document.forms["frmConv"].elements['IDLICITACION'].value;
	if (IDLicitacion=='-1')
		jQuery("#btnIncluirLic").hide();
	else
		jQuery("#btnIncluirLic").show();
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


//	Recupera un proveedor en todas las licitaciones
function ReactivarProveedor(IDProveedor)
{
	document.forms["frmConv"].elements['ACCION'].value='REACTIVAR';
	document.forms["frmConv"].elements['PARAMETROS'].value=IDProveedor;
	
	Enviar();
}


//	Incluye una licitación en la convocatoria
function IncluirLicitacion()
{
	var IDLicitacion=document.forms["frmConv"].elements['IDLICITACION'].value;

	document.forms["frmConv"].elements['ACCION'].value='INCLUIRLIC';
	document.forms["frmConv"].elements['PARAMETROS'].value=IDLicitacion;
	
	Enviar();
}

//	Quita una licitación de la convocatoria
function QuitarLicitacion(IDLicitacion)
{
	document.forms["frmConv"].elements['ACCION'].value='QUITARLIC';
	document.forms["frmConv"].elements['PARAMETROS'].value=IDLicitacion;
	
	Enviar();
}



