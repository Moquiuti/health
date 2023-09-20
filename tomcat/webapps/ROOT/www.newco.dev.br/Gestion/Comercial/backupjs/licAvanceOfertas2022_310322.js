//	JS para la página con el avance de las ofertas
//	Ultima revision ET 31mar22 12:36 licAvanceOfertas2022_310322.js

var sepCSV			=';';
var sepTextoCSV		='';
var saltoLineaCSV	='\r\n';



//
//	Funciones para crear fichero CSV adaptadas desde EMPDocs_221220.js
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



//	Descargar excel
function DescargarExcel()
{
	var oForm=document.forms['frmDocumentos'], cadenaCSV='';

	console.log("DescargarExcel");
	
	//	Preparamos la cabecera para la licitacion
	cadenaCSV=StringtoCSV(strInforme)+saltoLineaCSV+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strFechaInforme+':')+StringtoCSV(FechaInforme)+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strTitulo+':')+StringtoCSV(strTituloLic)+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strCodigo+':')+StringtoCSV(strCodigoLic)+saltoLineaCSV+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strFechaInforme+':')+StringtoCSV(FechaInforme)+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strFechaDecision+':')+StringtoCSV(FechaDecision)+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strDescripcion+':')+StringtoCSV(Descripcion)+saltoLineaCSV;
	if (CondEntrega!='') cadenaCSV+=StringtoCSV(strCondEntrega+':')+StringtoCSV(CondEntrega)+saltoLineaCSV;
	if (CondPago!='') cadenaCSV+=StringtoCSV(strCondPago+':')+StringtoCSV(CondPago)+saltoLineaCSV;
	if (CondOtras!='') cadenaCSV+=StringtoCSV(strCondOtras+':')+StringtoCSV(CondOtras)+saltoLineaCSV;
	if (MesesDuracion>0) cadenaCSV+=StringtoCSV(strMesesDuracion+':')+StringtoCSV(MesesDuracion)+saltoLineaCSV;
	
	if (chkTotal!='')
	{
		cadenaCSV+=StringtoCSV(strTotalALaVista+':')+StringtoCSV(TotalALaVista)+saltoLineaCSV;
		cadenaCSV+=StringtoCSV(strTotalAplazado+':')+StringtoCSV(TotalAplazado)+saltoLineaCSV;
	}
	
	if (chkTotalPedidos!='') cadenaCSV+=StringtoCSV(strTotalPedidos+':')+StringtoCSV(TotalPedidos)+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strTotalAdjudicado+':')+StringtoCSV(TotalAdjudicado)+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strProductos+':')+StringtoCSV(Productos)+saltoLineaCSV;

	cadenaCSV+=StringtoCSV(strProveedores+':')+StringtoCSV(Proveedores)+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strAhorroPorc+':')+StringtoCSV(AhorroPorc)+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strAhorro+':')+StringtoCSV(Ahorro)+saltoLineaCSV+saltoLineaCSV;


	//	Titulo de la tabla
	cadenaCSV+=strCabeceraExcel+saltoLineaCSV;
	
	//	Datos de los productos
	for (j=0; j<arrProductos.length; j++)
	{
		// Linea;Ref.Cliente;Producto;Unidad básica;Marca aut.;Cantidad;Precio;Udes.lote;Marca;
		cadenaCSV+=StringtoCSV(arrProductos[j].Contador)
					+StringtoCSV(arrProductos[j].Refestandar)
					+StringtoCSV(arrProductos[j].RefCliente)
					+StringtoCSV(arrProductos[j].Nombre)
					+StringtoCSV(arrProductos[j].UdBasica)
					+StringtoCSV(arrProductos[j].MarcasAceptables)
					+StringtoCSV(arrProductos[j].Cantidad)
					+StringtoCSV(arrProductos[j].Consumo)
					+StringtoCSV(arrProductos[j].NumOfertas)
					+StringtoCSV(arrProductos[j].PrecioRef)
					+StringtoCSV(arrProductos[j].PrecioMedio)
					+StringtoCSV(arrProductos[j].MejorPrecio)
					+StringtoCSV(arrProductos[j].Ahorro)
					+StringtoCSV(arrProductos[j].UdsXLote)
					+StringtoCSV(arrProductos[j].Marca)
					+StringtoCSV(arrProductos[j].Proveedor)
					+saltoLineaCSV
					;
	}

	DescargaMIME(StringToISO(cadenaCSV), 'AvanceOfertas.csv', 'text/csv');
	
}
