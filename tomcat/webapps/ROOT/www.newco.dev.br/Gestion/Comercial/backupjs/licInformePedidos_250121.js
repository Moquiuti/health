//	JS para la página de informe de pedidos de la licitacion
//	Ultima revision ET 25ene21 18:00 licInformePedidos_250121.js

var sepCSV			=';';		//	25ene21
var sepTextoCSV		='';		//	25ene21
var saltoLineaCSV	='\r\n';	//	25ene21



//
//	25ene21 Funciones para crear fichero CSV adaptadas desde EMPDocs_221220.js
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


//	25ene21 Descargar excel
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
	cadenaCSV+=StringtoCSV(strAhorro+':')+StringtoCSV(Ahorro)+saltoLineaCSV+saltoLineaCSV+saltoLineaCSV;

	//	Recorremos el array de proveedores
	for (i=0; i<arrProveedores.length; i++)
	{
		//	Datos del proveedor
		cadenaCSV+=StringtoCSV(strProveedor+':')+StringtoCSV(arrProveedores[i].Nombre)+saltoLineaCSV;
		cadenaCSV+=StringtoCSV(strPlazoEntrega+':')+StringtoCSV(arrProveedores[i].PlazoEntrega)+sepCSV+StringtoCSV(strFrete+':')+StringtoCSV(arrProveedores[i].Frete)+saltoLineaCSV;
		cadenaCSV+=StringtoCSV(strTotalAdjudicado+':')+StringtoCSV(arrProveedores[i].Total)+sepCSV+StringtoCSV(strPedidoMinimo+':')+StringtoCSV(arrProveedores[i].PedidoMinimo)+saltoLineaCSV;
		cadenaCSV+=StringtoCSV(strPlazoPago+':')+StringtoCSV(arrProveedores[i].PlazoPago)+sepCSV+StringtoCSV(strFormaPago+':')+StringtoCSV(arrProveedores[i].FormaPago)+saltoLineaCSV;
		cadenaCSV+=saltoLineaCSV+saltoLineaCSV;
		
		for (j=0; j<arrProveedores[i].Pedidos.length; j++)
		{
			
			cadenaCSV+=StringtoCSV(strPedido+' ('+arrProveedores[i].Pedidos[j].Contador+'):')+StringtoCSV(arrProveedores[i].Pedidos[j].Numero)+saltoLineaCSV;
			cadenaCSV+=StringtoCSV(strCentroCliente+':')+StringtoCSV(arrProveedores[i].Pedidos[j].CentroCliente)+saltoLineaCSV;
			cadenaCSV+=StringtoCSV(strTotal+':')+StringtoCSV(arrProveedores[i].Pedidos[j].Total)+saltoLineaCSV;
		
			//	Lineas pedidos
			cadenaCSV+=strCabeceraExcel+saltoLineaCSV;
			
			for (k=0; k<arrProveedores[i].Pedidos[j].Ofertas.length; k++)
			{
				cadenaCSV+=StringtoCSV(arrProveedores[i].Pedidos[j].Ofertas[k].RefCliente)
						+StringtoCSV(arrProveedores[i].Pedidos[j].Ofertas[k].Nombre)
						+StringtoCSV(arrProveedores[i].Pedidos[j].Ofertas[k].Marca)
						+StringtoCSV(arrProveedores[i].Pedidos[j].Ofertas[k].UdBasica)
						+StringtoCSV(arrProveedores[i].Pedidos[j].Ofertas[k].Tarifa)
						+StringtoCSV(arrProveedores[i].Pedidos[j].Ofertas[k].UdsXLote)
						+StringtoCSV(arrProveedores[i].Pedidos[j].Ofertas[k].Cantidad)
						+StringtoCSV(arrProveedores[i].Pedidos[j].Ofertas[k].TotalLinea)
						+StringtoCSV(arrProveedores[i].Pedidos[j].Ofertas[k].PrecioRef)
						+StringtoCSV(arrProveedores[i].Pedidos[j].Ofertas[k].Ahorro+'%')+saltoLineaCSV;
				
			}
			//	Lineas pedidos
			cadenaCSV+=saltoLineaCSV+saltoLineaCSV;
			
		}
	}

	DescargaMIME(StringToISO(cadenaCSV), 'InformePedidos.csv', 'text/csv');
	
}
