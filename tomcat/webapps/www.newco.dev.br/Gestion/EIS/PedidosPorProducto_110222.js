//	JS del listado de análisis de pedidos
//	ultima revisión: ET 11feb22 15:00 PedidosPorProducto_110222.js

var sepCSV			=';';		//	20ene21
var sepTextoCSV		='';		//	20ene21
var saltoLineaCSV	='\r\n';	//	20ene21



//
//	3mar21 Funciones para crear fichero CSV adaptadas desde EMPDocs_221220.js
//


//	quitamos ";" de las cadenas
function StringtoCSV(Cadena)
{
	var CadCSV=Cadena.replace('&amp;','&');
	CadCSV=CadCSV.replace(';','');

	//solodebug	if (CadCSV!=Cadena) debug('StringtoCSV. ['+Cadena+'] -> ['+CadCSV+']');

	return (sepTextoCSV+CadCSV+sepTextoCSV+sepCSV);
}

function NumbertoCSV(Number) {return (sepTextoCSV+Number.toString()+sepTextoCSV+sepCSV);}


function globalEvents(){

	jQuery(document).keypress(function(e){
		if(e.keyCode == 13){
			//alert('You pressed enter!');
			AplicarFiltro();
		}
	});
       

}//fin de globalEvent


function PrepararChecks()
{
	//	3abr18
	if(jQuery("#FINALIZADOS_CHECK").is(':checked'))
	{
		jQuery("#FINALIZADOS").val('S');
	}
	else
	{
		jQuery("#FINALIZADOS").val('N');
	}

	//	30jul19
	if(jQuery("#PENDIENTES_CHECK").is(':checked'))
	{
		jQuery("#PENDIENTES").val('S');
	}
	else
	{
		jQuery("#PENDIENTES").val('N');
	}

	//	24abr18
	if(jQuery("#URGENTES_CHECK").is(':checked'))
	{
		jQuery("#URGENTES").val('S');
	}
	else
	{
		jQuery("#URGENTES").val('N');
	}
                
	if(jQuery("#UTILFECHAENTREGA").is(':checked')){
		jQuery("#UTILFECHAENTREGA").val('S');
	}else{
		jQuery("#UTILFECHAENTREGA").val('N');
	}
        
	//	18dic18
	if(jQuery("#INVERTIRABONOS_CHECK").is(':checked'))
	{
		jQuery("#INVERTIRABONOS").val('S');
	}
	else
	{
		jQuery("#INVERTIRABONOS").val('N');
	}
}

function AplicarFiltro(){
	var form=document.forms[0];
	form.action='PedidosPorProducto.xsql';
	
	jQuery("#PAGINA").val('0');		//14dic16
    PrepararChecks();
	    
	SubmitForm(form);
}

function AplicarFiltroPagina(pag){
    var form=document.forms[0];
    form.elements['PAGINA'].value = pag;
 
    PrepararChecks();
        
	SubmitForm(form);

}

function OrdenarPor(Orden, Sentido){
	var form=document.forms[0];

	//alert('Orden:'+form.elements['ORDEN'].value+' Sentido:'+form.elements['SENTIDO'].value+'->'+Orden+':'+Sentido);

	if (form.elements['ORDEN'].value==Orden){
		if (form.elements['SENTIDO'].value=='ASC') form.elements['SENTIDO'].value='DESC';
		else  form.elements['SENTIDO'].value='ASC';
	}else{
		form.elements['ORDEN'].value=Orden;
		form.elements['SENTIDO'].value=Sentido;
	}
	
	//alert('Orden:'+form.elements['ORDEN'].value+' Sentido:'+form.elements['SENTIDO'].value);
	
	AplicarFiltro();
}

function DescargarExcel()
{
	var oForm=document.forms['frmDocumentos'], cadenaCSV='';

	console.log("DescargarExcel");
	
	//	Preparamos la cabecera
	cadenaCSV=StringtoCSV(strInforme)+saltoLineaCSV+saltoLineaCSV
			+StringtoCSV(strFechaInforme+':')+StringtoCSV(FechaInforme)+saltoLineaCSV
			+StringtoCSV(strTitulo+':')+StringtoCSV(Titulo)+saltoLineaCSV
			+StringtoCSV(strFechaInicio+':')+StringtoCSV(FechaInicio)+saltoLineaCSV
			+StringtoCSV(strFechaFinal+':')+StringtoCSV(FechaFinal)+saltoLineaCSV
			+StringtoCSV(strCentro+':')+StringtoCSV(Centro)+saltoLineaCSV
			+StringtoCSV(strProducto+':')+StringtoCSV(Producto)+saltoLineaCSV+saltoLineaCSV;


	cadenaCSV+=StringtoCSV(strRefCliente+':')+StringtoCSV(strProducto)+StringtoCSV(strUdBasica+':')
			+StringtoCSV(strPedidos+':')+StringtoCSV(strCantidad)+StringtoCSV(strTotal)+saltoLineaCSV;
	
	//	Recorremos el array de Productos
	for (var i=0; i<arrProductos.length; i++)
	{
		//Centro/Fecha pedido/Numero pedido/Codigo/Titulo/Total
		cadenaCSV+=	StringtoCSV(arrProductos[i].RefCliente)
					+StringtoCSV(arrProductos[i].Nombre)
					+StringtoCSV(arrProductos[i].UdBasica)
					+StringtoCSV(arrProductos[i].Pedidos)
					//+StringtoCSV(arrProductos[i].Lineas)
					+StringtoCSV(arrProductos[i].TotalCantidad)
					+StringtoCSV(arrProductos[i].TotalImporte)
					+saltoLineaCSV;
	}

	DescargaMIME(StringToISO(cadenaCSV), 'PedidosPorProducto.csv', 'text/csv');
	
}

//	30jul19 al marcar FINALIZADOS desmarca PENDIENTES y vice versa
function chkPendienteOFinalizadoChange(Control)
{
	var Alter=(Control=='FINALIZADOS')?'PENDIENTES':'FINALIZADOS';
	if(jQuery("#"+Control+"_CHECK").is(':checked'))
	{
		jQuery("#"+Alter+"_CHECK").attr('checked',false);
	}
}


