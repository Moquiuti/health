//	JS para el listado/buscador de roturas de stock
//	Ultima revision: ET 26may23 17.21 RoturasStock2022_260523.js

function Buscar()
{
	SubmitForm(document.forms['Buscador']);
}

function EjecutarAccion(Accion, Parametro)
{
	document.forms['Buscador'].elements.ACCION.value=Accion;
	document.forms['Buscador'].elements.PARAMETRO.value=Parametro;
	SubmitForm(document.forms['Buscador']);
}

//	3may21 Exporta la seleccion del usuario a CSV
function ExportarExcel()
{
	debug("DescargarExcel");

	cadenaCSV=StringtoCSV('RefEstandar')+StringtoCSV('Fecha')+StringtoCSV('FechaFinal')+StringtoCSV('Proveedor')
					+StringtoCSV('RefProveedor')+StringtoCSV('Producto')+StringtoCSV('Tipo')+StringtoCSV('Comentarios')+StringtoCSV('Alternativa')+StringtoCSV('Duracion')+saltoLineaCSV;

	for (i=0;i<arrRoturas.length;++i)
	{
		cadenaCSV+=StringtoCSV(arrRoturas[i].RefEstandar)
					+StringtoCSV(arrRoturas[i].Fecha)
					+StringtoCSV(arrRoturas[i].FechaFinal)
					+StringtoCSV(arrRoturas[i].Proveedor)
					+StringtoCSV(arrRoturas[i].RefProveedor)
					+StringtoCSV(arrRoturas[i].Producto)
					+StringtoCSV(arrRoturas[i].Tipo)
					+StringtoCSV(arrRoturas[i].Comentarios)
					+StringtoCSV(arrRoturas[i].Alternativa)
					+StringtoCSV(arrRoturas[i].Duracion)
					+saltoLineaCSV;
	}

	var Fecha=new Date;
	DescargaMIME(StringToISO(cadenaCSV), 'RoturasStock_'+Fecha.getDay()+(Fecha.getMonth()+1)+Fecha.getYear()+'.csv', 'text/csv');
}

		
/*	11may22 PENDIENTE DE IMPLEMENTAR
function NuevaRotura()
{
	MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/RoturasStock/NuevaRoturaStock.xsql','Nueva rotura de stock',100,100,0,0);
}*/

