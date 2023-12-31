// JS para el mantenimiento de productos (cat�logo proveedor)
// Ultima revisi�n: ET 22ene20 PROTarifas_071220.js

jQuery(document).ready(globalEvents);

function globalEvents(){
	//selecionar ofertas de proveedor

	//	12dic16	Marcamos la primera opci�n de men�
	jQuery("#pes_Tarifas").css('background','#3b569b');
	jQuery("#pes_Tarifas").css('color','#D6D6D6');

	// Se clica en pesta�as
	jQuery("#pes_Ficha").click(function(){
	
		//	Pendiente identificar si estamos en mantenimiento o en lectura
	
 		var IDProducto = document.forms['frmTarifas'].elements['PRO_ID'].value;
		window.location.assign("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten.xsql?PRO_ID="+IDProducto);

	});
	jQuery("#pes_Documentos").click(function(){
	
		//	Pendiente identificar si estamos en mantenimiento o en lectura
	
 		var IDProducto = document.forms['frmTarifas'].elements['PRO_ID'].value;
		window.location.assign("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODocs.xsql?PRO_ID="+IDProducto);

	});
	jQuery("#pes_Pack").click(function(){
	
		//	Pendiente identificar si estamos en mantenimiento o en lectura
	
 		var IDProducto = document.forms['frmTarifas'].elements['PRO_ID'].value;
		window.location.assign("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROPack.xsql?PRO_ID="+IDProducto);

	});
	
	if (arrTarifas.length>0)
		CambioCliente();
}//fin de globalEvents


//	Guarda una tarifa
function Guardar()
{
	var msg='';
	
	formu=document.forms['frmTarifas'];
	
	//	Comprobar campos
	//	IDCliente obligatiorio
	if(formu.elements['IDCLIENTE'].value == '-1')
		msg = msg + strClienteObligatorio+'\n';
		
	//	Importe en formato num�rico
	if ((formu.elements['IMPORTE'].value == '') || (isNaN(Number.parseFloat(formu.elements['IMPORTE'].value.replace('.','').replace(',','.')))))
		msg = msg + strErrorEnTarifa+'\n';

	//	FechaInicio
	if((formu.elements['FECHAINICIO'].value != '') && (CheckDate(formu.elements['FECHAINICIO'].value)))
		msg = msg +strErrorEnFechaInicio +'\n';

	//	Fecha final
	if((formu.elements['FECHAFINAL'].value != '') && (CheckDate(formu.elements['FECHAFINAL'].value)))
		msg = msg + strErrorEnFechaFin+'\n';

	//	Importe en formato num�rico
	if ((formu.elements['BONIF_COMPRA'].value != '') && (isNaN(Number.parseInt(formu.elements['BONIF_COMPRA'].value))))
		msg = msg + strNumeroIncorrecto.replace('[[NUMERO]]',formu.elements['BONIF_COMPRA'].value)+'\n';

	//	Importe en formato num�rico
	if ((formu.elements['BONIF_GRATIS'].value != '') && (isNaN(Number.parseInt(formu.elements['BONIF_GRATIS'].value))))
		msg = msg + strNumeroIncorrecto.replace('[[NUMERO]]',formu.elements['BONIF_GRATIS'].value)+'\n';

	if (msg!='')
	{
		alert(msg);
	}
	else
	{
		formu.elements['ACCION'].value = 'GUARDAR';
		formu.submit();
	}
}


//	Guarda una tarifa
function EliminarTarifa(IDCliente, IDSelGeo)
{
	var Pos=BuscaPosCliente(IDCliente, IDSelGeo);
	if (confirm(msgBorrarTarifa.replace('[[CLIENTE]]',arrTarifas[Pos].Cliente)))
	{
		jQuery('#IDCLIENTE').val(IDCliente);
		jQuery('#IDSELECCIONGEO').val(IDSelGeo);
		formu=document.forms['frmTarifas'];
		formu.elements['ACCION'].value = 'BORRAR';
		formu.submit();
	}
}


//	Al cambiar el desplegable de cliente, actualizar desplegable de tipos de negociaci�n
function CambioCliente()
{
	IDCliente=jQuery('#IDCLIENTE').val();
	
	//solodebug	
	console.log('CambioCliente. IDCliente:'+IDCliente);
	var count=0;
	
	jQuery('#IDSELECCIONGEO').val('');
	jQuery('#IDTIPONEGOCIACION').empty();

	if (IDCliente !='-1')
	{
		var Pos=BuscaPosCliente(IDCliente, 'CUALQUIERA');
		
		if (arrTarifas[Pos].PorAreaGeo=='S')
			jQuery('#tdAreaGeo').show();
		else
			jQuery('#tdAreaGeo').hide();

		for (var j=0;j<arrTarifas[Pos].DespTipoNeg.length;++j)
		{
			count++;
			//solodebug	console.log(arrTarifas[Pos].IDCliente+' TipoNeg:'+arrTarifas[Pos].DespTipoNeg[j].ID+':'+arrTarifas[Pos].DespTipoNeg[j].Nombre);
			jQuery('#IDTIPONEGOCIACION').append(new Option(arrTarifas[Pos].DespTipoNeg[j].Nombre,arrTarifas[Pos].DespTipoNeg[j].ID));
		}
	}
	else
	{
		jQuery('#tdAreaGeo').hide();
	}

	if ((IDCliente =='')||(IDCliente =='-1')||(count<=1))
		jQuery('#tdTipoNeg').hide();
	else
		jQuery('#tdTipoNeg').show();
}


//	Recupera los datos de la tarifa para facilitar su modificaci�n
function RecuperarTarifa(IDCliente, IDSelGeo)
{
	//	Primero el cambio de cliente, para informar tambi�n el desplegable de tipos de negociaci�n
	jQuery('#IDCLIENTE').val(IDCliente);
	CambioCliente();
	
	//solodebug	
	console.log('RecuperarTarifa. ID:'+IDCliente+' IDSelGeo:'+IDSelGeo);
	
	var Pos=BuscaPosCliente(IDCliente, IDSelGeo);
	
	//solodebug	
	console.log(arrTarifas[Pos].IDCliente);

	jQuery('#IMPORTE').val(arrTarifas[Pos].Importe);
	jQuery('#IDSELECCIONGEO').val(arrTarifas[Pos].IDSelGeo);
	jQuery('#IDDIVISA').val(arrTarifas[Pos].IDDivisa);
	jQuery('#FECHAINICIO').val(arrTarifas[Pos].FechaInicio);
	jQuery('#FECHAFINAL').val(arrTarifas[Pos].FechaLimite);
	jQuery('#IDTIPONEGOCIACION').val(arrTarifas[Pos].IDTipoNeg);
	jQuery('#NOMBREDOCUMENTO').val(arrTarifas[Pos].NombreDoc);
	jQuery('#IDDOCUMENTO').val(arrTarifas[Pos].IDDocumento);
	jQuery('#BONIF_COMPRA').val(arrTarifas[Pos].BonifCompra);
	jQuery('#BONIF_GRATIS').val(arrTarifas[Pos].BonifGratis);
}


//	Devuelve la posici�n del cliente
function BuscaPosCliente(IDCliente, IDSelGeo)
{
		//solodebug	
		console.log('BuscaPosCliente:'+IDCliente+' IDSelGeo:'+IDSelGeo);
	var Pos=-1;
	for (var i=0;(i<arrTarifas.length)&&(Pos==-1);++i)
	{
		//solodebug	
		console.log('BuscaPosCliente ('+i+'):'+arrTarifas[i].IDCliente+' IDSelGeo:'+arrTarifas[i].IDSelGeo);
		
		if ((arrTarifas[i].IDCliente==IDCliente)&&((IDSelGeo=='CUALQUIERA')||(arrTarifas[i].IDSelGeo==IDSelGeo)))
		{
			Pos=i;
		}
	}

	//solodebug	console.log('BuscaPosCliente ('+IDCliente+'). Devolviendo:'+Pos);

	return Pos;
}
