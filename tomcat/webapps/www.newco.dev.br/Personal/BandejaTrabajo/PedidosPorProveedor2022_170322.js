//	JS del listado de análisis de pedidos
//	ultima revisión: ET 17mar22 12:00 PedidosPorProveedor2022_170322.js

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
	form.action='PedidosPorProveedor2022.xsql';
	
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

function OrdenarPor(Orden){
	var form=document.forms[0];
        //alert(Orden);

	if (form.elements['ORDEN'].value==Orden){
		if (form.elements['SENTIDO'].value=='ASC') form.elements['SENTIDO'].value='DESC';
		else  form.elements['SENTIDO'].value='ASC';
	}else{
		form.elements['ORDEN'].value=Orden;
		form.elements['SENTIDO'].value='ASC';
	}
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
			+StringtoCSV(strProveedor+':')+StringtoCSV(Proveedor)+saltoLineaCSV+saltoLineaCSV;


	cadenaCSV+=StringtoCSV(strProveedores+':')+StringtoCSV(Proveedores)+saltoLineaCSV
			+StringtoCSV(strPedidos+':')+StringtoCSV(Pedidos)+saltoLineaCSV
			+StringtoCSV(strTotal+':')+StringtoCSV(Total)+saltoLineaCSV+saltoLineaCSV;
	
	//	Recorremos el array de proveedores
	for (var i=0; i<arrProveedores.length; i++)
	{
		//solodebug	console.log('Proveedor['+i+']:'+arrProveedores[i].Nombre);
	
		cadenaCSV+=StringtoCSV(arrProveedores[i].Nombre)+StringtoCSV(arrProveedores[i].NIF)+saltoLineaCSV;
		cadenaCSV+=strCabeceraExcelPrinc.replace('[DIV]',strDiv)+saltoLineaCSV;
		
		//	Centros
		for (j=0; j<arrProveedores[i].Centros.length; j++)
		{
			//solodebug	console.log('Proveedor['+i+'].Centros['+j+']:'+arrProveedores[i].Centros[j].Nombre);

			//	Pedidos
			for (k=0; k<arrProveedores[i].Centros[j].Pedidos.length; k++)
			{
				//solodebug	console.log('Proveedor['+i+'].Centros['+j+'].Pedidos['+k+']:'+arrProveedores[i].Centros[j].Pedidos[k].Fecha+':'+arrProveedores[i].Centros[j].Pedidos[k].Numero);

				//Centro/Fecha pedido/Numero pedido/Codigo/Titulo/Total
				cadenaCSV+=	StringtoCSV(arrProveedores[i].Centros[j].Nombre)
							+StringtoCSV(arrProveedores[i].Centros[j].Pedidos[k].Fecha)
							+StringtoCSV(arrProveedores[i].Centros[j].Pedidos[k].Numero)
							+StringtoCSV(arrProveedores[i].Centros[j].Pedidos[k].Codigo)
							+StringtoCSV(arrProveedores[i].Centros[j].Pedidos[k].Titulo)
							+StringtoCSV(arrProveedores[i].Centros[j].Pedidos[k].Total)
							+saltoLineaCSV;
			}

		}
		
		cadenaCSV+=sepCSV+sepCSV+sepCSV+sepCSV+StringtoCSV('Total:')+NumbertoCSV(arrProveedores[i].Total)+saltoLineaCSV;
		cadenaCSV+=saltoLineaCSV+saltoLineaCSV;
	}

	DescargaMIME(StringToISO(cadenaCSV), 'PedidosPorProveedor.csv', 'text/csv');
	
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


