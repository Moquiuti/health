//	JS para la página con las ofertas NO seleccionadas
//	Ultima revision ET 21abr23 10:45 licOfertasSeleccionadas2022_210423.js



//
//	22dic20 Funciones para crear fichero CSV adaptadas desde EMPDocs_221220.js
//


//	10ene20 Descargar excel
function DescargarExcel()
{
	var oForm=document.forms['frmDocumentos'], cadenaCSV='';

	console.log("DescargarExcel");

	
	//	Preparamos la cabecera para la licitacion
	cadenaCSV=StringtoCSV(strTitulo)+saltoLineaCSV+saltoLineaCSV;

	cadenaCSV+=StringtoCSV(strFechaInforme+':')+StringtoCSV(FechaInforme)+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strFechaDecision+':')+StringtoCSV(FechaDecision)+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strDescripcion+':')+StringtoCSV(Descripcion)+saltoLineaCSV;
	if (CondEntrega!='') cadenaCSV+=StringtoCSV(strCondEntrega+':')+StringtoCSV(CondEntrega)+saltoLineaCSV;
	if (CondPago!='') cadenaCSV+=StringtoCSV(strCondPago+':')+StringtoCSV(CondPago)+saltoLineaCSV;
	if (CondOtras!='') cadenaCSV+=StringtoCSV(strCondOtras+':')+StringtoCSV(CondOtras)+saltoLineaCSV;
	if (MesesDuracion>0) cadenaCSV+=StringtoCSV(strMesesDuracion+':')+StringtoCSV(MesesDuracion)+saltoLineaCSV;

	cadenaCSV+=StringtoCSV(strResponsable+':')+StringtoCSV(Responsable)+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strEmail+':')+StringtoCSV(Email)+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strTelefono+':')+StringtoCSV(Telefono)+saltoLineaCSV;
	
	cadenaCSV+=saltoLineaCSV+StringtoCSV(strRefMVM)+StringtoCSV(strRefCliente)+StringtoCSV(strNombre)+StringtoCSV(strUdBasica)+StringtoCSV(strCantidad)+StringtoCSV(strPrecioRef)+StringtoCSV(strTotalLinea)+saltoLineaCSV;

	//	Recorremos el array de proveedores
	for (i=0; i<arrProductos.length; i++)
	{
		cadenaCSV+=StringtoCSV(arrProductos[i].Refestandar)
					+StringtoCSV((arrProductos[i].RefCentro=='')?arrProductos[i].RefCliente:arrProductos[i].RefCentro)
					+StringtoCSV(arrProductos[i].Nombre)
					+StringtoCSV(arrProductos[i].UdBasica)
					+StringtoCSV(arrProductos[i].Cantidad)
					+StringtoCSV(arrProductos[i].PrecioRef)
					+StringtoCSV(arrProductos[i].TotalLinea)
					+saltoLineaCSV;
	}

	DescargaMIME(StringToISO(cadenaCSV), 'ProductosNoSeleccionados.csv', 'text/csv');
 	
}



//	31mar22 Abre o activa la página de la licitación, comprobando si ya estaba abierta
function AbrirLicitacion(IDLicitacion)
{
	
	if ((window.opener && window.opener.open && !window.opener.closed)&&(window.opener.name=='Licitacion'))
	{
		console.log('AbrirLicitacion. Opener:'+window.opener.name);
		window.opener.focus();
		window.close();
	}
	else
	{
		console.log('AbrirLicitacion. Opener: cerrado');
		MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/LicitacionV2_2022.xsql?LIC_ID='+IDLicitacion,'Licitacion',90,90,10,10);
	}
}

