//	8oct18 Informar procedimiento en convocatoria Elementos Especiales


function Enviar(){
	var form=document.forms["Procedimiento"];
	SubmitForm(form);
}


//	8oct18 Si se modifican desplegables, recarga el formulario
function CambioDesplegables(Accion)
{
	document.forms["Procedimiento"].elements["ACCION"].value=Accion;
	Enviar();
}


//	8oct18 Revisa los campos principales y envía el formulario a la base de datos
function ValidarYEnviar()
{
	var Errores='';

	var Parametros=	NVL(document.forms["Procedimiento"].elements["REEMBOLSO_CARTERA"].value,'0')
				+'|'+NVL(document.forms["Procedimiento"].elements["IDTIPOLIQUIDACION"].value,'0')	//+document.forms["Procedimiento"].elements["BONIF_CORPORATIVA"].value
				+'|'+NVL(document.forms["Procedimiento"].elements["CANT_BONIFICADA"].value,'0')
				+'|'+NVL(document.forms["Procedimiento"].elements["CONSUMO_META"].value,'0')
				+'|'	//+document.forms["Procedimiento"].elements["PROD_BONIFICADO"].value
				+'|'	//+document.forms["Procedimiento"].elements["CANT_PROD_BONIFICADO"].value;

	//	Validaciones:
				

	//	Recuperamos los datos de los productos
	for (i=0;i<document.forms["Procedimiento"].elements.length;++i)
	{
		if (Piece(document.forms["Procedimiento"].elements[i].name,'_',0)=="REFPROV")
		{
			var ID=Piece(document.forms["Procedimiento"].elements[i].name,'_',1);
			
			if (document.forms["Procedimiento"].elements[i].value=='')
				Errores	+= document.forms["Procedimiento"].elements['REFCLIENTE_'+ID].value+': '+strReferenciaObligatoria+'\n\r';
			else
				Parametros=Parametros+'|'+ID+'#'+document.forms["Procedimiento"].elements[i].value
								+'#'+document.forms["Procedimiento"].elements['RANGDIAM_'+ID].value
								+'#'+document.forms["Procedimiento"].elements['RANGLONG_'+ID].value
								+'#'+document.forms["Procedimiento"].elements['BONIF_'+ID].value
								;
		}
	}
				
	document.forms["Procedimiento"].elements["ACCION"].value='GUARDAR_CAMBIOS';
	document.forms["Procedimiento"].elements["PARAMETROS"].value=Parametros;
	
	//solodebug 	alert('ValidarYEnviar:'+Parametros);
	
	
	if (Errores=='')
	{
		//solodebug 
		console.log('ValidarYEnviar:'+Parametros);
		
		Enviar();
	}
	else
		alert(Errores);
	
}


//	9oct18	Recalcula los totales a medida que se informan los campos
function RecalcularTotales()
{
	var Total=0,Total1=0,Total2=0,TotalFinal,BonifGlob1=0,BonifGlob2=0,BonifProd=0,BonifTotal;


	//var Reembolso=toFloat(document.forms["Procedimiento"].elements["REEMBOLSO_CARTERA"].value);
	//var CantBonificada=toFloat(document.forms["Procedimiento"].elements["CANT_BONIFICADA"].value);
	//var ConsumoMeta=toFloat(document.forms["Procedimiento"].elements["CONSUMO_META"].value);
	var Reembolso=InputToFloat("REEMBOLSO_CARTERA");
	var CantBonificada=InputToFloat("CANT_BONIFICADA");
	var ConsumoMeta=InputToFloat("CONSUMO_META");


	//	Recuperamos los datos de los productos
	for (i=0;i<document.forms["Procedimiento"].elements.length;++i)
	{
		if (Piece(document.forms["Procedimiento"].elements[i].name,'_',0)=="REFPROV")
		{
			var ID=Piece(document.forms["Procedimiento"].elements[i].name,'_',1);
			
			if (document.forms["Procedimiento"].elements[i].value!='')
			{
			
				Total+=toFloat(document.forms["Procedimiento"].elements['TOTALLINEA_'+ID].value);
				
				if (document.forms["Procedimiento"].elements['BONIF_'+ID].value!='')
				{
					BonifProd+=toFloat(document.forms["Procedimiento"].elements['BONIF_'+ID].value)*toFloat(document.forms["Procedimiento"].elements['PRECIO_'+ID].value);
				}
				
			}
		}
	}
	

	BonifGlob1=Total*(Reembolso/100);

	Total1=Total-BonifGlob1;
	
	if (ConsumoMeta>0)
		BonifGlob2=Total1*(CantBonificada/(CantBonificada+ConsumoMeta));
	
	Total2=Total1-BonifGlob2;
	
	TotalFinal=Total2-BonifProd;

	BonifTotal=BonifGlob1+BonifGlob2+BonifProd;
	
	
	
	//console.log('total:'+Total+' BonifGlob1:'+BonifGlob1+' Total1:'+Total1+' BonifGlob2:'+BonifGlob2+' Total2:'+Total2+' bonif:'+BonifProd+' TotalFinal:'+TotalFinal);
	//console.log('total:'+FormateaNumero(Total)+' BonifGlob1:'+FormateaNumero(BonifGlob1)+' Total1:'+FormateaNumero(Total1)+' BonifGlob2:'+FormateaNumero(BonifGlob2)
	//			+' Total2:'+FormateaNumero(Total2)+' bonif:'+FormateaNumero(BonifProd)+' Total3:'+FormateaNumero(Total3));
	//console.log('total:'+Total.toLocaleString()+' BonifGlob1:'+BonifGlob1.toLocaleString()+' Total1:'+Total1.toLocaleString()
	//			+' BonifGlob2:'+BonifGlob2.toLocaleString()+' Total2:'+Total2.toLocaleString()+' bonif:'+BonifProd.toLocaleString()+' Total3:'+TotalFinal.toLocaleString());
	
	
	//jQuery("#TOTAL").html(Total.toLocaleString());
	//jQuery("#BONIF1").html(BonifGlob1.toLocaleString());
	//jQuery("#TOTAL2").html(Total1.toLocaleString());
	//jQuery("#BONIF2").html(BonifGlob2.toLocaleString());
	//jQuery("#BONIFPROD").html(BonifProd.toLocaleString());
	//jQuery("#TOTAL_DESCUENTOS").html(BonifTotal.toLocaleString());
	//jQuery("#TOTAL_FINAL").html(TotalFinal.toLocaleString());

	jQuery("#TOTAL").html(conFormato(Total));
	jQuery("#BONIF1").html(conFormato(BonifGlob1));
	//jQuery("#TOTAL2").html(conFormato(Total1));
	jQuery("#BONIF2").html(conFormato(BonifGlob2));
	jQuery("#BONIFPROD").html(conFormato(BonifProd));
	jQuery("#TOTAL_DESCUENTOS").html(conFormato(BonifTotal));
	jQuery("#TOTAL_FINAL").html(conFormato(TotalFinal));
	
}


//	convierta a número flotante a partir de una cadena
function toFloat(cadena)
{
	//var sinPuntos=cadena.replace(/\./g,'');
	return (parseFloat(cadena.replace(/\./g,'').replace(',','.')));
}


//	Comprueba que el valor sea numérico y luego convierte a cadena, si no es numérico, pone un 0
function InputToFloat(control)
{
	cadena=document.forms["Procedimiento"].elements[control].value;
	
	if (isNaN(cadena.replace(/\./g,'').replace(',','.')))
	{
		document.forms["Procedimiento"].elements[control].value=0;
		return 0;
	}
	else return toFloat(cadena);
	
}


//	convierta a número flotante a partir de una cadena
function conFormato(numero)
{
	if (isNaN(numero))
		return '';
	
	return numero.toLocaleString();
}

//	convierta a número flotante a partir de una cadena
function NVL(cadena, siNull)
{
	if (cadena=='')
		return siNull;
	
	return cadena;
}












