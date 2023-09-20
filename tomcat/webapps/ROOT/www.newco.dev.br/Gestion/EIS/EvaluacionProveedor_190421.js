//	JS para Evaluacion de proveedor
//	Ultima revision: ET 19abr21 11:15 EvaluacionProveedor_190421.js

function inicio()
{
	console.log('inicio');
	Graficos();
}

//recarga la página con los nuevos parámetros de búsqueda
function Recarga()
{
	document.forms["frmFiltro"].submit();
}

function CambioProveedorActual()
{
	Recarga();
}

function CambioCentroCliente()
{
	Recarga();
}

function CambioEmpresaActual()
{
	Recarga();
}

//	19abr21 En caso de seleccionar "Otros" mostramos los valores por defecto
function CambioPeriodo()
{
	if (jQuery('#PERIODO').val()!='OTROS')
		Recarga();
	else
	{
		jQuery('.avanzadas').show();
	}
}

function Buscar()
{
	//	Comprueba fechas
	Recarga();
}


//	Mantenemos el cliente seleccionado al cambiar a Indicadores
function Condiciones()
{
	window.location="http://www.newco.dev.br/Gestion/Comercial/CondicionesProveedores.xsql?IDCLIENTE="+document.forms["frmFiltro"].elements["IDCLIENTE"].value;
}

//	Mantenemos el cliente seleccionado al cambiar a Indicadores
function Clasificacion()
{
	window.location="http://www.newco.dev.br/Gestion/EIS/ClasificacionProveedoresEIS.xsql?IDCLIENTE="+document.forms["frmFiltro"].elements["IDCLIENTE"].value;
}

//	Mantenemos el cliente seleccionado al cambiar a Evaluacion proveedor
function Indicadores()
{
	window.location="http://www.newco.dev.br/Gestion/EIS/IndicadoresProveedoresEIS.xsql?IDCLIENTE="+document.forms["frmFiltro"].elements["IDCLIENTE"].value
				+"&IDPROVEEDOR="+document.forms["frmFiltro"].elements["IDPROVEEDOR"].value
				+"&PERIODO="+document.forms["frmFiltro"].elements["PERIODO"].value
				+"&FECHA_INICIO="+document.forms["frmFiltro"].elements["FECHA_INICIO"].value
				+"&FECHA_FINAL="+document.forms["frmFiltro"].elements["FECHA_FINAL"].value;
}

//	28abr21 Ocultar tabla de pedidos
function OcultarPedidos()
{
	jQuery('#divTodosPedidos').hide();
	jQuery('#divMostraPedidos').show();
}

//	28abr21 Mostrar tabla de pedidos
function MostrarPedidos()
{
	jQuery('#divTodosPedidos').show();
	jQuery('#divMostraPedidos').hide();
}







