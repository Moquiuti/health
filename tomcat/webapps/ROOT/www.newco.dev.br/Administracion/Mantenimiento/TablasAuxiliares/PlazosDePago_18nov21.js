//	JS para la página  de plazos de pago
//	Ultima revision ET 18nov21 11:30 PlazosDePago_18nov21.js

var sepCSV			=';';
var sepTextoCSV		='';
var saltoLineaCSV	='\r\n';


//	Borra un plazo de pago
function Borrar(ID)
{
    var seguroBorrar= document.forms['MensajeJS'].elements['SEGURO_BORRAR'].value;
	if (confirm(seguroBorrar))
	{
	      document.forms[0].elements['ACCION'].value='BORRAR';
	      document.forms[0].elements['PARAMETROS'].value=ID;
		  SubmitForm(document.forms[0]);
	}
}

function Insertar()
{
	  document.forms[0].elements['ACCION'].value='NUEVO';
	  document.forms[0].elements['PARAMETROS'].value=ScapeHTMLString(document.forms[0].elements['DESCRIPCION'].value);
	  SubmitForm(document.forms[0]);
}

function selEmpresaChange()
{
	  SubmitForm(document.forms[0]);
}



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



//	18nov21 Descargar excel
function DescargarExcel()
{
	
	cadenaCSV=strID+sepCSV+strPlazo+saltoLineaCSV;
	
	//	Recorremos el array de plazos de pago
	for (var i=0; i<arrPlazos.length; i++)
	{
	
		cadenaCSV+=arrPlazos[i].ID+sepCSV+arrPlazos[i].Descripcion+saltoLineaCSV;
	}

	DescargaMIME(StringToISO(cadenaCSV), 'PlazosDePago.csv', 'text/csv');
	
}
