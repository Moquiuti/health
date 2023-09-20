//	JS para la página con las ofertas seleccionadas, "Vencedores"	
//	Ultima revision ET 20ene21 12:00 VencedoresYAlternativas_200121.js

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
	//	Preparamos la cabecera para la licitacion
	cadenaCSV=StringtoCSV(strInforme)+saltoLineaCSV+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strFechaInforme+':')+StringtoCSV(FechaInforme)+saltoLineaCSV;
	//cadenaCSV+=StringtoCSV(strEmpresa+':')+StringtoCSV(strEmpresaLic)+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strTitulo+':')+StringtoCSV(strTituloLic)+saltoLineaCSV;
	cadenaCSV+=StringtoCSV(strCodigo+':')+StringtoCSV(strCodigoLic)+saltoLineaCSV+saltoLineaCSV;

	//	Creamos la cadena de titulos
	var  cadAlternativas='',cadTitulo=strCabeceraExcelPrinc;
	for (var i=1;i<=numColumnas;++i)
	{
		cadAlternativas+='Alternativa '+i+sepCSV+sepCSV+sepCSV+sepCSV;
		cadTitulo+=strCabeceraExcelAlt;
	}
	cadTitulo+=strCabeceraExcelJust;
	
	//	Recorremos el array de proveedores
	for (var i=0; i<arrProveedores.length; i++)
	{
	
		cadenaCSV+=sepCSV+sepCSV+sepCSV+sepCSV+sepCSV+arrProveedores[i].Nombre+sepCSV+sepCSV+sepCSV+sepCSV+cadAlternativas+saltoLineaCSV;
		cadenaCSV+=cadTitulo+saltoLineaCSV;
		
		//	Datos de los productos y oferta ganadora
		for (j=0; j<arrProveedores[i].Productos.length; j++)
		{
			// Linea;Ref.Cliente;Producto;Unidad básica;Marca aut.;Cantidad;Precio;Udes.lote;Marca;
			cadenaCSV+=StringtoCSV(arrProveedores[i].Productos[j].Contador)
						+StringtoCSV(arrProveedores[i].Productos[j].RefCliente)
						+StringtoCSV(arrProveedores[i].Productos[j].Nombre)
						+StringtoCSV(arrProveedores[i].Productos[j].UdBasica)
						+StringtoCSV(arrProveedores[i].Productos[j].MarcasAceptables)
						+StringtoCSV(arrProveedores[i].Productos[j].Cantidad)
						+StringtoCSV(arrProveedores[i].Productos[j].Tarifa)
						+StringtoCSV(arrProveedores[i].Productos[j].UdsXLote)
						+StringtoCSV(arrProveedores[i].Productos[j].Marca);
						
			//	Datos de las alternativas
			for (k=0; k<arrProveedores[i].Productos[j].Ofertas.length; k++)
			{
				//Fornecedor;Precio;Udes.lote;Marca;
				cadenaCSV+=StringtoCSV(arrProveedores[i].Productos[j].Ofertas[k].Proveedor)
							+StringtoCSV(arrProveedores[i].Productos[j].Ofertas[k].Precio)
							+StringtoCSV(arrProveedores[i].Productos[j].Ofertas[k].UdsXLote)
							+StringtoCSV(arrProveedores[i].Productos[j].Ofertas[k].Marca);
			}

			cadenaCSV+=StringtoCSV(arrProveedores[i].Productos[j].Justificacion)+saltoLineaCSV;

		}
		
		cadenaCSV+=saltoLineaCSV+saltoLineaCSV;
	}

	DescargaMIME(StringToISO(cadenaCSV), 'Vencedores.csv', 'text/csv');
	
}
