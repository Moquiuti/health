//	JS para la página con las ofertas seleccionadas, "Vencedores"	
//	Ultima revision ET 20ene21 12:00 licInformeProveedoresYOfertas_200121.js

var sepCSV			=';';		//	20ene21
var sepTextoCSV		='';		//	20ene21
var saltoLineaCSV	='\r\n';	//	20ene21



//
//	20ene21 Funciones para crear fichero CSV adaptadas desde EMPDocs_221220.js
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



//	20ene21 Descargar excel
function DescargarExcel()
{
	var oForm=document.forms['frmDocumentos'], cadenaCSV='';

	console.log("DescargarExcel");

	
	//	Preparamos la cabecera para la licitacion
	cadenaCSV=StringtoCSV(strInforme)+saltoLineaCSV+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strFechaInforme+':')+StringtoCSV(FechaInforme)+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strEmpresa+':')+StringtoCSV(strEmpresaLic)+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strTitulo+':')+StringtoCSV(strTituloLic)+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strCodigo+':')+StringtoCSV(strCodigoLic)+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strComprador+':')+StringtoCSV(strCompradorLic)+saltoLineaCSV;
	cadenaCSV+=StringtoCSV('')+StringtoCSV(strDireccionLic)+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strTipo+':')+StringtoCSV(strTipoLic)+saltoLineaCSV;

	//	Recorremos el array de proveedores
	cadenaCSV+=saltoLineaCSV+strCabeceraProveedores+saltoLineaCSV;
	for (var i=0; i<arrProveedores.length; i++)
	{

		//<item name="Cabecera_Prov_CSV_provyofertas">Fornecedor;Estado;Vendedor;Telefono;Email;Ped.minimo;Prazo entrega;Forma pago;Frete;Comentarios</item>
		//	Datos del proveedor
		cadenaCSV+=StringtoCSV(arrProveedores[i].Nombre)+StringtoCSV(arrProveedores[i].Provincia)+StringtoCSV(arrProveedores[i].VendNombre)+StringtoCSV(arrProveedores[i].VendTelefono)
				+StringtoCSV(arrProveedores[i].VendEmail)+StringtoCSV(arrProveedores[i].PedidoMinimo)+StringtoCSV(arrProveedores[i].PlazoEntrega)+StringtoCSV(arrProveedores[i].PlazoPago)
				+StringtoCSV(arrProveedores[i].Frete)+StringtoCSV(arrProveedores[i].Comentarios)
				+saltoLineaCSV;
	}

	//	Recorremos el array de ofertas
	cadenaCSV+=saltoLineaCSV+saltoLineaCSV+strCabeceraProductos+saltoLineaCSV;
	for (var i=0; i<arrOfertas.length; i++)
	{

		//<item name="Cabecera_Prod_CSV_provyofertas">Linea;Producto;Adjudicado;Ref.Cliente;Fabricante;Embalaje;Proveedor;Comentarios;Cantidad;Precio sin/iva;Total línea</item>	//Sin comentarios
		//	Datos de la oferta
		cadenaCSV+=StringtoCSV(arrOfertas[i].Linea)+StringtoCSV(arrOfertas[i].Producto)+StringtoCSV(arrOfertas[i].Adjudicada)+StringtoCSV(arrOfertas[i].RefCliente)
				+StringtoCSV(arrOfertas[i].Marca)+StringtoCSV(arrOfertas[i].UdBasica)+StringtoCSV(arrOfertas[i].Proveedor)+StringtoCSV(arrOfertas[i].Comentarios)
				+StringtoCSV(arrOfertas[i].Cantidad)+StringtoCSV(arrOfertas[i].Tarifa)+StringtoCSV(arrOfertas[i].TotalLinea)
				+saltoLineaCSV;
	}
	
	//solodebug	console.log("cadenaCSV:"+cadenaCSV);
	
	DescargaMIME(StringToISO(cadenaCSV), 'InformeProveedoresYOfertas.csv', 'text/csv');
	
}
