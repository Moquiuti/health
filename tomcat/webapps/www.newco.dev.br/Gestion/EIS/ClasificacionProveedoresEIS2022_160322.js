//	Funciones javascript para clasificación de proveedores
//	ultima revision: ET 16mar22 10:00 ClasificacionProveedoresEIS2022_160322.js

var sepCSV			=';';		//	13ene20
var sepTextoCSV		='';		//	13ene20
var saltoLineaCSV	='\r\n';	//	13ene20

jQuery(document).ready(globalEvents);

function globalEvents(){
 // var numRows = jQuery("select#NumLineas").val();
 // mostrarLineas(numRows);
}


//	Por defecto, la ordenación por nombre será ASC, y el resto DESC
function OrdenarPor(Orden)
{
	if (document.forms["formProv"].elements["ORDEN"].value == Orden)
	{
		document.forms["formProv"].elements["SENTIDO"].value = (document.forms["formProv"].elements["SENTIDO"].value=='ASC')?'DESC':'ASC';
	}
	else
	{
		document.forms["formProv"].elements["ORDEN"].value = Orden;
		document.forms["formProv"].elements["SENTIDO"].value = (document.forms["formProv"].elements["ORDEN"].value=='NOMBRE')?'ASC':'DESC';
	}
	document.forms["formProv"].submit();
}

function CambioEmpresaActual(IDCliente)
{
	document.forms["formProv"].elements["IDCLIENTE"].value = IDCliente;
	document.forms["formProv"].elements["ORDEN"].value = 'PED_TOT';
	document.forms["formProv"].elements["SENTIDO"].value = 'DESC';
	document.forms["formProv"].submit();
}




//
//	Funciones para crear fichero CSV copiadas desde EMPDocs_100120.js
//

//	quitamos ";" de las cadenas
function StringtoCSV(Cadena)
{
	var CadCSV=Cadena.replace('&amp;','&');
	CadCSV=CadCSV.replace(';','');

	//solodebug
	if (CadCSV!=Cadena) debug('StringtoCSV. ['+Cadena+'] -> ['+CadCSV+']');

	return (sepTextoCSV+CadCSV+sepTextoCSV+sepCSV);
}

function NumbertoCSV(Number) {return (sepTextoCSV+Number.toString()+sepTextoCSV+sepCSV);}


//	10ene20 Descargar excel
function DescargarExcel()
{
	var oForm=document.forms['formProv'], cadenaCSV='';

	console.log("DescargarExcel");

	
	//	Preparamos la cabecera para la licitacion
	cadenaCSV=StringtoCSV('Empresa: '+Empresa)+saltoLineaCSV+saltoLineaCSV;
	
	cadenaCSV+='POSICION;NOMBRE;NOTAMEDIA;PRODUCTOSADJUDICADOS;NUMDOCS_EMPRESA;NUMDOCS_PRODUCTOS;PLAZOENTREGA;PLAZOENVIO;EIS_PROV_LICITACIONESGANADAS;EIS_PROV_LICITACIONESRESP;EIS_PROV_LICITACIONES;EIS_PROV_LIC_RATIOGANTOT;EIS_PROV_LIC_RATIOGANRESP;EIS_PROV_NUMEROPEDIDOS;EIS_PROV_IMPORTEPEDIDOS;EIS_PROV_NUMPEDIDOSRETRASADOS;EIS_PROV_PORCPEDIDOSRETRASADOS;EIS_PROV_NUMPEDIDOSPARCIALES;EIS_PROV_PORCPEDIDOSPARCIALES;EIS_PROV_RETRASODIAS;EIS_PROV_RETRASOMEDIO;EIS_PROV_INCIDENCIASPEDIDOS;EIS_PROV_INCIDENCIASPRODUCTOS;EIS_PROV_EVALUACIONES'+saltoLineaCSV;
	
	for (i=0; i<oForm.elements.length; i++)
	{
		//solodebug console.log("DescargarExcel. revisando "+oForm.elements[i].name.substring(0,6));
		if (oForm.elements[i].name.substring(0,6)=="EXCEL_")
		{
			//solodebug console.log("DescargarExcel. revisando "+oForm.elements[i].name.substring(0,6)+' OK');
			cadenaCSV+=oForm.elements[i].value+saltoLineaCSV;
		}
	}

	DescargaMIME(StringToISO(cadenaCSV), 'DocumentacionEmpresa.csv', 'text/csv');		//	http://www.newco.dev.br/General/descargas_151117.js
	
}

//	Mantenemos el cliente seleccionado al cambiar a Indicadores
function Condiciones()
{
	window.location="http://www.newco.dev.br/Gestion/Comercial/CondicionesProveedores2022.xsql?IDCLIENTE="+document.forms["formProv"].elements["IDCLIENTE"].value;
}

//	Mantenemos el cliente seleccionado al cambiar a Indicadores
function Indicadores()
{
	window.location="http://www.newco.dev.br/Gestion/EIS/IndicadoresProveedoresEIS2022.xsql?IDCLIENTE="+document.forms["formProv"].elements["IDCLIENTE"].value;
}

//	Mantenemos el cliente seleccionado al cambiar a Indicadores
function IndicadoresProv(IDProv)
{
	window.location="http://www.newco.dev.br/Gestion/EIS/IndicadoresProveedoresEIS2022.xsql?IDCLIENTE="+document.forms["formProv"].elements["IDCLIENTE"].value+"&IDPROVEEDOR="+IDProv;
}

//	Mantenemos el cliente seleccionado al cambiar a Indicadores
function Evaluacion()
{
	window.location="http://www.newco.dev.br/Gestion/EIS/EvaluacionProveedor2022.xsql?IDCLIENTE="+document.forms["formProv"].elements["IDCLIENTE"].value;
}


//	7jun22 Mantenemos el cliente seleccionado al cambiar a Indicadores
function FichaCompleta(IDEmpresa)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPFichaCompleta.xsql?EMP_ID="+IDEmpresa,'Ficha Empresa',90,80,0,-50)
}

